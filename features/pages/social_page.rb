class SocialPage
  include Capybara::DSL

  def scroll_to_footer
    page.execute_script("window.scrollTo(0, document.body.scrollHeight)")
  end

  def has_social_icons?
    page.has_selector?('.social') && page.has_selector?('[data-test="social-facebook"]')
  end

  def click_facebook_icon
    @current_window = page.current_window
    click_link('Facebook')
  end

  def new_tab_opened?
    page.windows.length > 1
  end

  def switch_to_new_tab
    @new_window = (page.windows - [@current_window]).last
    page.switch_to_window(@new_window)
  end

  def facebook_url
    page.current_url
  end

  def facebook_title
    page.title
  end
end 