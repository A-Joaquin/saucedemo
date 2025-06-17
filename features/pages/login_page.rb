class LoginPage
  include Capybara::DSL

  def visit_page
    visit 'https://www.saucedemo.com/'
  end

  def fill_username(username)
    find('[data-test="username"]').set(username)
  end

  def fill_password(password)
    find('[data-test="password"]').set(password)
  end

  def fill_valid_credentials
    fill_username('standard_user')
    fill_password('secret_sauce')
  end

  def click_login
    find('[data-test="login-button"]').click
  end

  def on_products_page?
    page.has_current_path?(/inventory\.html/, url: true) && page.has_css?('.title', text: 'Products')
  end

  def has_error_message?(msg)
    page.has_css?('[data-test="error"]', text: msg)
  end
end 