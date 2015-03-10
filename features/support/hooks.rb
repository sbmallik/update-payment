After ('@s1,@s2') do | scenario |
#	page.driver.browser.close
#	puts "Closing the browser after executing scenario #{scenario.title}."
	page.execute_script "window.close();"
	Capybara.send(:session_pool).delete_if do
		|key, value| key =~ /selenium/i
	end
end
