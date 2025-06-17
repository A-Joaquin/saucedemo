class CartPage
  include Capybara::DSL

  def add_to_cart(item_name)
    find(:xpath, "//div[text()='#{item_name}']/ancestor::div[@class='inventory_item']//button[contains(text(), 'Add to cart')]").click
  end

  def remove_from_cart(item_name)
    product_element = find('.inventory_item', text: item_name, wait: 5)
    product_element.find('button[data-test*="remove"]').click
  end

  def click_cart_link
    find('.shopping_cart_link', wait: 5).click
    page.has_selector?('.cart_contents_container', wait: 5)
  end

  def cart_badge_count
    badge = first('.shopping_cart_badge', wait: 5)
    badge ? badge.text : nil
  end

  def has_cart_badge?(count)
    has_css?('.shopping_cart_badge', text: count, wait: 5)
  end

  def has_no_cart_badge?
    has_no_css?('.shopping_cart_badge', wait: 5)
  end

  def click_remove_button
    click_button('Remove')
  end

  def click_product_title(product_name)
    find('.inventory_item_name', text: product_name).click
  end

  def on_cart_details_page_for?(product_name)
    has_css?('.inventory_details_name', text: product_name, wait: 5)
  end

  def on_product_details_page_for?(product_name)
    page.has_current_path?(/inventory-item.html/, url: true) && has_selector?('.inventory_details_name', text: product_name, wait: 5)
  end

  def product_price
    find('.inventory_details_price', wait: 5).text
  end

  def product_description
    find('.inventory_details_desc', wait: 5).text
  end
end 