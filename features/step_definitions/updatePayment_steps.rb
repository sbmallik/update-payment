Given(/^I have no browser cookies$/) do
	browser = Capybara.current_session.driver.browser
	browser.manage.delete_all_cookies
end

When(/^I am on the USCP home page$/) do
	visit ui_url('/')
	wait_for_pageload
end

Then (/^The homepage loads$/) do
	expect(page).to have_selector(:id, 'section_home')
end

When(/^I hover on the Firefly Login icon$/) do
	find('.site-nav-firefly-span').hover
end

When(/^I click Log in in pushdown$/) do
	find('.ff-login-btn').click
end

Then(/^the log in page loads$/) do
	expect(page).to have_selector('main.login')
end

def standardLogIn(email="", password="")
	fill_in('username', :with => email)
	fill_in('password', :with => password)
	find('.primary.left.last').click
end

#Scenario Outline
When(/^I log in with "(.*?)" and "(.*?)"$/) do |email,password|
	standardLogIn(email,password)
end

Then(/^Logins with "(.*?)" should "(.*?)"$/) do |payment_status, show_modal|
	if payment_status=='expired'or'lastpaymentfailed' and show_modal=='yes'
		step %{Update Your Payment Information modal displays}
	else
		step %{Update Your Payment Information modal does not display}
	end
end

Then(/^I log out$/) do
	find('.ff-logout-btn.sam-returns').click
end

#s2 and s3
When(/^Update Your Payment Information modal displays$/) do
	within("div.expired-card-modal-wrapper") do
		find_link('Update payment information')
	end
end

When(/^I click "(.*?)" link$/) do |link|
	@element = find('a.cc-payment-button') if link=='update your payment information' #Click button in modal to update your payment info
	@element = find('.cc-remind-later-link') if link=='remind me later' #Click link in modal for remind me later"
	$expected_url = @element[:href]
	@element.click
end

Then(/^A new window for the SAM Change Your Payment page opens$/) do
	first_window = page.driver.browser.window_handles.first    #window handle to the new window
	new_window = page.driver.browser.window_handles.last    #window handle to the new window
	page.driver.browser.switch_to.window new_window         #switch control to the new window
#  expect(current_url).to match 'https://account-stage.democratandchronicle.com/payment-information/?licenseId=10232320' #new modal window URL matches expected URL            #Probably not required for a modal window
	expect(current_url).to match $expected_url #new modal window URL matches expected URL            #Probably not required for a modal window
	page.driver.browser.close
	page.driver.browser.switch_to.window first_window
end

Then(/^Update Your Payment Information modal does not display$/) do
	expect(page).not_to have_css('div.expired-card-modal-wrapper')  #modal window no longer displays
end

#After(:each) do
#	Capybara.reset_sessions!
#end
