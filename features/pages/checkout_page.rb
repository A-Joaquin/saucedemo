class CheckoutPage
  include Capybara::DSL

  def proceed_to_checkout
    find('.shopping_cart_link', wait: 5).click
    page.has_selector?('.cart_contents_container', wait: 5)
    find('#checkout', wait: 5).click
    page.has_current_path?(/checkout-step-one.html/, url: true)
  end

  def fill_checkout_info(first_name, last_name, postal_code)
    fill_in 'first-name', with: first_name
    fill_in 'last-name', with: last_name
    fill_in 'postal-code', with: postal_code
  end

  def continue_to_overview
    find('#continue', wait: 5).click
    page.has_current_path?(/checkout-step-two.html/, url: true)
  end

  def attempt_continue_to_overview
    find('#continue', wait: 5).click
  end

  def complete_purchase
    find('#finish', wait: 5).click
    page.has_current_path?(/checkout-complete.html/, url: true)
  end

  def cancel_checkout
    find('#cancel', wait: 5).click
  end

  def on_checkout_info_page?
    page.has_current_path?(/checkout-step-one.html/, url: true) && page.has_content?('Checkout: Your Information')
  end

  def has_validation_error?(msg)
    page.has_selector?('[data-test="error"]', text: msg, wait: 5)
  end

  def order_confirmation_message
    find('.complete-header', wait: 5).text
  end

  def cart_item_names
    all('.cart_item .inventory_item_name').map(&:text)
  end

  def cart_item_count
    all('.cart_item').count
  end

  def has_cart_item?(product_name)
    within('.cart_list') do
      page.has_selector?('.inventory_item_name', text: product_name, wait: 5)
    end
  end

  def subtotal_label
    find('.summary_subtotal_label', wait: 5).text
  end

  def subtotal_value
    subtotal_label.match(/\$(\d+\.\d+)/)[1].to_f
  end

  def individual_prices
    all('.inventory_item_price').map { |el| el.text.gsub('$', '').to_f }
  end

  def open_cart
    find('.shopping_cart_link', wait: 5).click
  end

  def has_cart_product?(product_name)
    within('.cart_contents_container') do
      page.has_selector?('.inventory_item_name', text: product_name, wait: 5)
    end
  end

  def continue_shopping_if_possible
    find('#continue-shopping', wait: 5).click if page.has_selector?('#continue-shopping')
  end
end 