def cartHasMedia?
 for item in Input.cart.line_items
  product = item.variant.product
   if !(product.tags.include?("Media"))
    return true
   end
 end
 return false
end

if cartHasMedia?
 Output.shipping_rates = Input.shipping_rates.delete_if do |shipping_rate|
  shipping_rate.name.upcase.include?("MEDIA MAIL")
 end

end

Output.shipping_rates = Input.shipping_rates
