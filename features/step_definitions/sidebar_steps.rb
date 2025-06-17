When('I open the sidebar menu') do
    unless page.has_selector?('#inventory_sidebar_link', visible: true, wait: 1)
      button_to_open = find('#react-burger-menu-btn', wait: 5)
      button_to_open.click
      expect(page).to have_selector('#inventory_sidebar_link', visible: true, wait: 5)
    end
  end
  
  When('I click {string} in the sidebar') do |link_text|
    link_id = case link_text
              when 'All Items' then 'inventory_sidebar_link'
              when 'About' then 'about_sidebar_link'
              when 'Logout' then 'logout_sidebar_link'
              when 'Reset App State' then 'reset_sidebar_link'
              else raise "Unknown sidebar link: #{link_text}"
              end
    find("##{link_id}", visible: true, wait: 5).click
  end
  
  When('I close the sidebar menu') do
    find('.bm-cross-button', visible: true, wait: 5).click
    expect(page).not_to have_selector('#inventory_sidebar_link', visible: true, wait: 3)
  end
  
  Then('the sidebar menu should be closed') do
    expect(page).not_to have_selector('#inventory_sidebar_link', visible: true, wait: 3)
    expect(page).not_to have_selector('#about_sidebar_link', visible: true, wait: 1)
    expect(page).to have_selector('#react-burger-menu-btn', visible: true, wait: 5)
  end
  
  Then(/^the sidebar menu should be closed \(or not present on login page\)$/) do
    if page.has_current_path?(/\/(index\.html)?$/, url: true) || page.current_url.end_with?("/")
      expect(page).not_to have_selector('#react-burger-menu-btn', wait: 3)
      expect(page).not_to have_selector('#inventory_sidebar_link', wait: 1)
      expect(page).not_to have_selector('#about_sidebar_link', wait: 1)
    else
      expect(page).not_to have_selector('#inventory_sidebar_link', visible: true, wait: 3)
      expect(page).not_to have_selector('#about_sidebar_link', visible: true, wait: 1)
      expect(page).to have_selector('#react-burger-menu-btn', visible: true, wait: 5)
    end
  end
  
  
  Then('I should be redirected to the {string} page') do |expected_url|
    expect(page.current_url).to eq(expected_url)
    
    case expected_url
    when /saucelabs\.com/
      expect(page).to have_selector('h1', text: 'Build apps users love with AI-driven insights', wait: 10)
      expect(page).to have_title(/Sauce Labs/, wait: 10)
    when /inventory\.html/
      expect(page).to have_content('Products', wait: 5)
    end
  end
  
  When('I add the first product to the cart from the products page') do
    expect(page).to have_current_path(/inventory.html/, url: true)
    add_button = first('.inventory_item .btn_primary.btn_inventory', wait: 5)
    expect(add_button).not_to be_nil, "No 'Add to cart' button found on the products page."
    add_button.click
    expect(page).to have_selector('.shopping_cart_badge', text: '1', wait: 5)
  end
  
  Then('the cart should be empty') do
    expect(page).not_to have_selector('.shopping_cart_badge', wait: 5)
  end