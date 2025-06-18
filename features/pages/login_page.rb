class LoginPage
  include Capybara::DSL

  USERNAME_FIELD = '[data-test="username"]'
  PASSWORD_FIELD = '[data-test="password"]'
  LOGIN_BUTTON = '[data-test="login-button"]'
  ERROR_MESSAGE = '[data-test="error"]'
  PRODUCTS_TITLE = '.title'
  PRODUCTS_PATH = /inventory\.html/

  # Navega a la página de login
  def load
    visit '/'
  end

  # Ingresa el nombre de usuario
  def fill_username(username)
    find(USERNAME_FIELD, wait: 5).set(username)
  end

  # Ingresa la contraseña
  def fill_password(password)
    find(PASSWORD_FIELD, wait: 5).set(password)
  end

  # Hace clic en el botón de login
  def click_login
    find(LOGIN_BUTTON, wait: 5).click
  end

  # Devuelve true si está en la página de productos
  def on_products_page?
    page.has_current_path?(PRODUCTS_PATH, url: true, wait: 5) && page.has_css?(PRODUCTS_TITLE, text: 'Products', exact: true, count: 1, wait: 5)
  end

  # Devuelve true si aparece el mensaje de error
  def has_error_message?(msg)
    page.has_css?(ERROR_MESSAGE, text: msg, wait: 5)
  end
end