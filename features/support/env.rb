require 'capybara/cucumber'
require 'selenium-webdriver'
require 'fileutils'

# Configuración de Capybara mejorada
Capybara.register_driver :selenium_chrome do |app|
  chrome_options = Selenium::WebDriver::Chrome::Options.new

  # Opciones básicas
  chrome_options.add_argument('--incognito')
  chrome_options.add_argument('--disable-dev-shm-usage')
  chrome_options.add_argument('--no-sandbox')
  chrome_options.add_argument('--disable-gpu')
  
  # Performance optimizations
  chrome_options.add_argument('--disable-extensions')
  chrome_options.add_argument('--disable-plugins')
  chrome_options.add_argument('--disable-images') # Opcional para tests más rápidos
  
  # Modo headless condicional
  chrome_options.add_argument('--headless') if ENV['HEADLESS'] == 'true'
  
  # Window size para consistencia
  chrome_options.add_argument('--window-size=1920,1080')
  
  # Preferencias adicionales
  chrome_options.add_preference('profile.password_manager_enabled', false)
  chrome_options.add_preference('credentials_enable_service', false)
  chrome_options.add_preference('profile.default_content_setting_values.notifications', 2)

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: chrome_options)
end

# Driver para Firefox (alternativo)
Capybara.register_driver :selenium_firefox do |app|
  firefox_options = Selenium::WebDriver::Firefox::Options.new
  firefox_options.add_argument('--headless') if ENV['HEADLESS'] == 'true'
  
  Capybara::Selenium::Driver.new(app, browser: :firefox, options: firefox_options)
end

# Configuración del driver por defecto
Capybara.default_driver = ENV['BROWSER']&.to_sym || :selenium_chrome
Capybara.javascript_driver = Capybara.default_driver

# Configuraciones de tiempo y comportamiento
Capybara.default_max_wait_time = ENV['WAIT_TIME']&.to_i || 10
Capybara.default_normalize_ws = true
Capybara.ignore_hidden_elements = true
Capybara.exact = true
Capybara.match = :prefer_exact
Capybara.visible_text_only = true

# Configuración de URLs base
Capybara.app_host = 'https://www.saucedemo.com'
Capybara.server_host = 'localhost'

# Crear directorios necesarios
FileUtils.mkdir_p('screenshots') unless Dir.exist?('screenshots')
FileUtils.mkdir_p('reports') unless Dir.exist?('reports')

# Configuración para diferentes entornos
case ENV['TEST_ENV']
when 'staging'
  Capybara.app_host = 'https://staging.saucedemo.com'
when 'local'
  Capybara.app_host = 'http://localhost:3000'
else
  # production por defecto
  Capybara.app_host = 'https://www.saucedemo.com'
end

puts "🚀 Test environment: #{ENV['TEST_ENV'] || 'production'}"
puts "🌐 Base URL: #{Capybara.app_host}"
puts "🔧 Driver: #{Capybara.default_driver}"
puts "⏱️  Max wait time: #{Capybara.default_max_wait_time}s"
puts "👁️  Headless: #{ENV['HEADLESS'] == 'true' ? 'Yes' : 'No'}"