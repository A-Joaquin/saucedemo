class SidebarPage
  include Capybara::DSL

  BURGER_MENU_BTN = '#react-burger-menu-btn'
  SIDEBAR_LINKS = {
    'All Items' => 'inventory_sidebar_link',
    'About' => 'about_sidebar_link',
    'Logout' => 'logout_sidebar_link',
    'Reset App State' => 'reset_sidebar_link'
  }
  SIDEBAR_CROSS_BTN = '.bm-cross-button'
  INVENTORY_SIDEBAR_LINK = '#inventory_sidebar_link'
  ABOUT_SIDEBAR_LINK = '#about_sidebar_link'
  PRODUCTS_TITLE = 'Products'

  # Abre el menú lateral (sidebar)
  def open_sidebar
    unless page.has_selector?(INVENTORY_SIDEBAR_LINK, visible: true, wait: 1)
      find(BURGER_MENU_BTN, wait: 5).click
      page.has_selector?(INVENTORY_SIDEBAR_LINK, visible: true, wait: 5)
    end
  end

  # Hace clic en un enlace del sidebar por texto
  def click_sidebar_link(link_text)
    link_id = SIDEBAR_LINKS[link_text] or raise "Unknown sidebar link: #{link_text}"
    find("##{link_id}", visible: true, wait: 5).click
  end

  # Cierra el menú lateral
  def close_sidebar
    find(SIDEBAR_CROSS_BTN, visible: true, wait: 5).click
  end

  # Devuelve true si el sidebar está cerrado
  def sidebar_closed?
    page.has_no_selector?(INVENTORY_SIDEBAR_LINK, visible: true, wait: 3) &&
      page.has_no_selector?(ABOUT_SIDEBAR_LINK, visible: true, wait: 1) &&
      page.has_selector?(BURGER_MENU_BTN, visible: true, wait: 5)
  end

  # Devuelve true si el sidebar está cerrado o no está presente en login
  def sidebar_closed_on_login_page?
    if page.has_current_path?(/\/(index\.html)?$/, url: true) || page.current_url.end_with?("/")
      page.has_no_selector?(BURGER_MENU_BTN, wait: 3) &&
        page.has_no_selector?(INVENTORY_SIDEBAR_LINK, wait: 1) &&
        page.has_no_selector?(ABOUT_SIDEBAR_LINK, wait: 1)
    else
      sidebar_closed?
    end
  end

  # Devuelve true si la URL actual es la esperada
  def redirected_to?(expected_url)
    page.current_url == expected_url
  end

  # Devuelve true si está en la página de SauceLabs
  def on_saucelabs_page?
    page.has_selector?('h1', text: 'Build apps users love with AI-driven insights', wait: 10) &&
      page.has_title?(/Sauce Labs/, wait: 10)
  end

  # Devuelve true si está en la página de inventario
  def on_inventory_page?
    page.has_content?(PRODUCTS_TITLE, wait: 5)
  end
end 