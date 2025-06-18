require_relative '../pages/social_page'

social_page = SocialPage.new

Given('I scroll to the footer') do
  social_page.scroll_to_footer
end

Given('I can see the social media icons') do
  expect(social_page.social_icons_present?).to be true
end

When('I click on the Facebook icon') do
  social_page.click_facebook_icon
end

Then('a new tab should open') do
  expect(social_page.new_tab_opened?).to be true
  social_page.switch_to_new_tab
end

Then('the Facebook URL should be {string}') do |url|
  expect(social_page.current_url).to eq(url)
end

Then('the Facebook page title should contain {string}') do |title|
  expect(social_page.current_title).to include(title)
end

Then('the social media link should match:') do |table|
  table.hashes.each do |row|
    platform = row['platform']
    expected_url = row['url']
    expected_title = row['title']
    
    expect(social_page.current_url).to include(expected_url)
    
    if expected_title
      expect(social_page.current_title).to include(expected_title)
    end
  end
end