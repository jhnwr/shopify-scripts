FREEBIE_PRODUCT_ID = xxxxxxx
CART_TOTAL_FOR_DISCOUNT_APPLIED = Money.new(cents: 100) * 25
DISCOUNT_MESSAGE = "your message here"

freebie_in_cart = false
cart_price_exceeds_discounted_freebie_amount = false
cost_of_freebie = Money.zero

# Test if the freebie is in the cart, also get its cost if it is so we can deduct from the cart total
Input.cart.line_items.select do |line_item|
  product = line_item.variant.product
  if product.id == FREEBIE_PRODUCT_ID
    freebie_in_cart = true
    cost_of_freebie = line_item.line_price
  end
end

# If the freebie exists in the cart, check the subtotal of the other items to see if the freebie should be discounted
if freebie_in_cart
  cart_subtotal_minus_freebie_cost = Input.cart.subtotal_price - cost_of_freebie
  if cart_subtotal_minus_freebie_cost >= CART_TOTAL_FOR_DISCOUNT_APPLIED
    cart_price_exceeds_discounted_freebie_amount = true
  end
end

# Only true if the freebie is in the cart
was_discount_applied = false
if cart_price_exceeds_discounted_freebie_amount
  Input.cart.line_items.each do |item|
    if item.variant.product.id == FREEBIE_PRODUCT_ID && was_discount_applied == false
      if item.quantity > 1
        new_line_item = item.split(take: 1)
        new_line_item.change_line_price(Money.new(cents: 21), message: DISCOUNT_MESSAGE)
        Input.cart.line_items << new_line_item
        next
      else
        item.change_line_price(Money.new(cents: 21), message: DISCOUNT_MESSAGE)
      end
    end
  end
end

Output.cart = Input.cart
