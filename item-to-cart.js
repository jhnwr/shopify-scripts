// add item to cart. this code goes in theme.liquid before the last body tag
// use discounts in shopify to make item free

<script> 
      window.onload = function(){
        let cartContainsFreeProduct = false;
        let cartContainsQualifyingProduct = false;
        console.log(cartContainsFreeProduct)
        console.log(cartContainsQualifyingProduct)
     
        const qualifyingProductsArray = [....];
        const freeProductVariantId = ....;
        console.log(qualifyingProductsArray);
               
        {% for item in cart.items %}
        if({{ item.id }} === freeProductVariantId){
          cartContainsFreeProduct = true; 
          console.log({{ item.id }})
        }
        //if({{ item.id }} === qualifyingProductVariantId){
        if (qualifyingProductsArray.includes({{ item.id }})){
          cartContainsQualifyingProduct = true;
          console.log({{ item.id }})
        }
        {% endfor %}
        console.log(cartContainsFreeProduct)
        console.log(cartContainsQualifyingProduct)

        
        // If cart contains qualifying product and doesn't already contain free product, add qty 1 of free product
        if(cartContainsQualifyingProduct === true && cartContainsFreeProduct === false) {
          let formData = {
             'items': [{
              'id': freeProductVariantId,
              'quantity': 1
              }]
            };
          jQuery.post('/cart/add.json', formData)
          .done(function() {window.location.reload()})
         } 
      }
      
    </script>
