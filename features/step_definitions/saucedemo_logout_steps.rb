  When('I open the menu') do
    find('#react-burger-menu-btn').click
  end
  
  When('I click the logout button') do
    find('#logout_sidebar_link').click
  end
  
  Then('I should be redirected to the login page') do
    expect(page).to have_selector('input[type="submit"][value="Login"]', wait: 5)
  end
  
  When('I try to visit the products page directly') do
    visit 'https://www.saucedemo.com/inventory.html'
  end