  When('I add the first product to the cart') do
    add_button = first('.inventory_item .btn_primary.btn_inventory', wait: 5)
    expect(add_button).not_to be_nil, "No 'Add to cart' button found for the first available product. Ensure you are on the inventory page."
    add_button.click
    expect(page).to have_selector('.shopping_cart_badge', text: '1', wait: 5)
  end
  
  When('I add the second product to the cart') do
    add_button = first('.inventory_item .btn_primary.btn_inventory', wait: 5)
    expect(add_button).not_to be_nil, "Could not find an available 'Add to cart' button for a second product. (Was the first product added and its button state updated?)"
    add_button.click
    expect(page).to have_selector('.shopping_cart_badge', text: '2', wait: 5)
  end
  
  When('I go to the cart') do
    find('.shopping_cart_link').click
    expect(page).to have_selector('#checkout', wait: 5)
  end
  
  When('I click the checkout button') do
    find('#checkout', wait: 5).click
  end
  
  When('I fill in my information with first name {string}, last name {string}, and postal code {string}') do |first, last, zip|
    fill_in 'First Name', with: first
    fill_in 'Last Name', with: last
    fill_in 'Zip/Postal Code', with: zip
  end
  
  When('I continue to the overview') do
    click_button('Continue')
  end
  
  When('I finish the purchase') do
    find('#finish', wait: 5).click
  end
  
  When('I cancel the purchase') do
    click_button('Cancel')
  end
  
  Then('I should see the confirmation message {string}') do |msg|
    expect(page).to have_content(msg)
  end

  When('I cancel the information entry') do
    click_button('Cancel')
  end

  Then('I should be redirected to the cart page') do
    expect(page).to have_current_path(/cart.html/, url: true)
    # También puedes verificar la presencia de algún elemento único del carrito:
    expect(page).to have_content('Your Cart')
  end

  Then('the total should be correct') do
    # Espera explícitamente que haya 2 artículos en el carrito en la página de resumen.
    # El Background añade 1, el escenario añade el 2do.
    prices = all('.cart_item', count: 2, wait: 10).map do |item_element|
      # Encuentra el div del precio dentro de la etiqueta del artículo y espera a que su texto contenga dígitos.
      price_text_with_digits = item_element.find('.cart_item_label .inventory_item_price', text: /\d/).text
      # Extrae la parte numérica del texto del precio.
      price_text_with_digits[/[\\d\\.]+/].to_f
    end
    subtotal = find('.summary_subtotal_label').text[/[\\d\\.]+/].to_f
    expect(prices.sum).to eq(subtotal)
  end

  When('I remove all items from the cart') do
    # Itera sobre todos los botones "Remove" y haz clic en ellos
    # Es importante usar `all` y luego iterar, porque el número de botones cambiará
    all('.cart_item .btn_secondary.cart_button').each do |remove_button|
      remove_button.click
    end
    # Verifica que el badge del carrito desaparezca o no exista
    expect(page).not_to have_selector('.shopping_cart_badge', wait: 2)
  end

  Then('I should still be on the cart page') do
    expect(page).to have_current_path(/cart.html/, url: true)
    expect(page).to have_content('Your Cart')
  end

  Then('I should be on the checkout overview page') do
    expect(page).to have_current_path(/checkout-step-two.html/, url: true)
    expect(page).to have_content('Checkout: Overview')
  end

  Then('I should see the text {string}') do |text_content|
    expect(page).to have_content(text_content)
  end

  When('I navigate back to the previous page') do
    page.go_back
  end

  Then('I should be on the checkout information page') do
    expect(page).to have_current_path(/checkout-step-one.html/, url: true)
    expect(page).to have_content('Checkout: Your Information')
  end