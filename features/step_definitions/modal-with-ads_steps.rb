Given(/^I am on the USCP home page with "(.*?)" AD$/) do | ad_type |
	ad_type.downcase!
	if ad_type == 'gravity'
		visit ui_url("/?usatai=7070&usatan=preview&usatl=gravity-pushdown")
	elsif ad_type == 'billboard'
		visit ui_url("/?usatai=7070&usatan=preview&usatl=billboard-test")
	elsif ad_type == 'pushdown'
		visit ui_url("/?usatai=7070&usatan=preview&usatl=ta-pushdown-201403")
	elsif ad_type == 'takeover'
		visit ui_url("/?usatai=7070&usatan=usatoday_preview&usatl=sbtakeoverexample201407")
	else
		raise "Cannot open unknown advertisement #{ad_type}"
	end
	wait_for_pageload
end

Then(/^The "(.*?)" AD displays$/) do | ad_type |
	wait_for_animations
	ad_type.downcase!
	if ad_type == 'takeover'
		find('.leavebehind-sponsoredby').click
		expect(page).to have_css('.starbuckstransition201407')
	else
		expect(page).to have_css(".partner-placement.partner-#{ad_type}-ad")
	end
	wait_for_pageload
end

When(/^I click on Partner Scroll Login link$/) do
	find('.partner-scroll-login', visible: :true).click
end

Then(/^The login modal window loads$/) do
	expect(page).to have_css('.partner-login-modal')
end

When(/^I click the login button$/) do
	find('.firefly-signin-btn.sam-returns').click
end

Then(/^Locate the leave behind AD$/) do
	expect(page).to have_css('.leavebehind-sponsoredby', visible: :true)
end
