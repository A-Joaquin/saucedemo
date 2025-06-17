class SidebarPage
  include Capybara::DSL

  def open_sidebar
    unless page.has_selector?('#inventory_sidebar_link', visible: true, wait: 1)
      button_to_open = find('#react-burger-menu-btn', wait: 5)
      button_to_open.click
      page.has_selector?('#inventory_sidebar_link', visible: true, wait: 5)
    end
  end

  def click_sidebar_link(link_text)
    link_id = case link_text
              when 'All Items' then 'inventory_sidebar_link'
              when 'About' then 'about_sidebar_link'
              when 'Logout' then 'logout_sidebar_link'
              when 'Reset App State' then 'reset_sidebar_link'
              else raise "Unknown sidebar link: #{link_text}"
              end
    find("##{link_id}", visible: true, wait: 5).click
  end

  def close_sidebar
    find('.bm-cross-button', visible: true, wait: 5).click
    page.has_no_selector?('#inventory_sidebar_link', visible: true, wait: 3)
  end

  def sidebar_closed?
    page.has_no_selector?('#inventory_sidebar_link', visible: true, wait: 3) &&
      page.has_no_selector?('#about_sidebar_link', visible: true, wait: 1) &&
      page.has_selector?('#react-burger-menu-btn', visible: true, wait: 5)
  end

  def sidebar_closed_on_login_page?
    if page.has_current_path?(/\/(index\.html)?$/, url: true) || page.current_url.end_with?("/")
      page.has_no_selector?('#react-burger-menu-btn', wait: 3) &&
        page.has_no_selector?('#inventory_sidebar_link', wait: 1) &&
        page.has_no_selector?('#about_sidebar_link', wait: 1)
    else
      sidebar_closed?
    end
  end

  def redirected_to?(expected_url)
    page.current_url == expected_url
  end

  def on_saucelabs_page?
    page.has_selector?('h1', text: 'Build apps users love with AI-driven insights', wait: 10) &&
      page.has_title?(/Sauce Labs/, wait: 10)
  end

  def on_inventory_page?
    page.has_content?('Products', wait: 5)
  end
end 