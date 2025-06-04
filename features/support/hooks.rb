Before do
  # Limpiar cookies y storage antes de cada escenario
  page.driver.browser.manage.delete_all_cookies if page.driver.respond_to?(:browser)
  
  # Reset de estado del navegador
  page.reset_session! if page.respond_to?(:reset_session!)
end

Before('@login_required') do
  # Hook específico para escenarios que requieren login
  visit 'https://www.saucedemo.com/'
  fill_in 'user-name', with: 'standard_user'
  fill_in 'password', with: 'secret_sauce'
  click_button 'Login'
  expect(page).to have_current_path(/inventory\.html/, url: true)
end

After do |scenario|
  # Screenshot en caso de fallo
  if scenario.failed?
    timestamp = Time.now.strftime('%Y%m%d_%H%M%S')
    screenshot_name = "failure_#{scenario.name.gsub(/\s+/, '_')}_#{timestamp}.png"
    screenshot_path = "screenshots/#{screenshot_name}"
    
    # Crear directorio si no existe
    FileUtils.mkdir_p('screenshots')
    
    # Tomar screenshot
    page.save_screenshot(screenshot_path)
    puts "Screenshot saved: #{screenshot_path}"
    
    # Para reports de Cucumber (opcional)
    attach screenshot_path, 'image/png' if respond_to?(:attach)
  end
end

After do
  # Logout si estamos en páginas que requieren autenticación
  if page.has_selector?('#react-burger-menu-btn', wait: 1)
    begin
      find('#react-burger-menu-btn').click
      find('#logout_sidebar_link', wait: 2).click
    rescue Capybara::ElementNotFound
      # Si no puede hacer logout, simplemente continúa
    end
  end
  
  # Limpiar carrito si existe
  if page.has_selector?('.shopping_cart_badge', wait: 1)
    begin
      find('.shopping_cart_link').click
      all('.cart_item .btn_secondary.cart_button').each(&:click)
    rescue Capybara::ElementNotFound
      # Si no puede limpiar carrito, continúa
    end
  end
end

# Hook para performance testing
Before('@performance') do
  # Configurar métricas de rendimiento
  @start_time = Time.now
end

After('@performance') do
  execution_time = Time.now - @start_time
  puts "Scenario execution time: #{execution_time.round(2)} seconds"
  
  # Fallar si toma más de 10 segundos
  expect(execution_time).to be < 10, "Scenario took too long: #{execution_time.round(2)}s"
end

# Hook para datos de prueba específicos
Before('@with_cart_items') do
  # Agregar productos al carrito para escenarios específicos
  visit 'https://www.saucedemo.com/inventory.html'
  first('.inventory_item .btn_primary.btn_inventory').click
  expect(page).to have_selector('.shopping_cart_badge', text: '1', wait: 5)
end

After('@checkout and not @validation and not @cancellation') do |scenario|
  # Ejecutar si el escenario pasó exitosamente hasta este punto
  # y estamos en la página de checkout overview
  if scenario.passed? && page.current_url.include?('checkout-step-two.html')
    # Completar la compra
    click_button 'Finish'
    
    # Verificar la confirmación del pedido
    expect(page).to have_content('Thank you for your order!', wait: 5)
    expect(page).to have_current_path(/checkout-complete\.html/, url: true)
  end
end