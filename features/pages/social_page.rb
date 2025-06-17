class SocialPage
  include Capybara::DSL

  FOOTER = 'footer'
  SOCIAL_CONTAINER = '.social'
  FACEBOOK_ICON = '[data-test="social-facebook"]'
  FACEBOOK_LINK_TEXT = 'Facebook'

  # Hace scroll al footer
  def scroll_to_footer
    page.execute_script("window.scrollTo(0, document.body.scrollHeight)")
  end

  # Devuelve true si los íconos sociales están presentes
  def social_icons_present?
    page.has_selector?(SOCIAL_CONTAINER, wait: 5) && page.has_selector?(FACEBOOK_ICON, wait: 5)
  end

  # Hace clic en el ícono de Facebook
  def click_facebook_icon
    @current_window = page.current_window
    click_link(FACEBOOK_LINK_TEXT, wait: 5)
  end

  # Devuelve true si se abrió una nueva pestaña
  def new_tab_opened?
    page.windows.length > 1
  end

  # Cambia el foco a la nueva pestaña
  def switch_to_new_tab
    @new_window = (page.windows - [@current_window]).last
    page.switch_to_window(@new_window)
  end

  # Devuelve la URL de la pestaña actual
  def current_url
    page.current_url
  end

  # Devuelve el título de la pestaña actual
  def current_title
    page.title
  end
end 