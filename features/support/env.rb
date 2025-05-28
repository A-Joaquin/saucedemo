require 'capybara/cucumber'
require 'selenium-webdriver'

Capybara.register_driver :selenium_chrome do |app|
	chrome_options = Selenium::WebDriver::Chrome::Options.new

	chrome_options.add_preference('profile.password_manager_enabled', false)
	chrome_options.add_preference('credentials_enable_service', false)
  
	Capybara::Selenium::Driver.new(app, browser: :chrome, options: chrome_options)
end

Capybara.default_driver = :selenium_chrome
Capybara.default_max_wait_time = 5