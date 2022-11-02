# RedPandaiOS task

Api to fetch product ids http://35.154.26.203/product-ids

Data for this product ids is available on firebase realtime database

# Realtime database nodes are:

Product name: 'product-name/${product_id}'

Product price: 'product-price/${product_id}'

Product image: 'product-image/${product_id}'

Product description: 'product-desc/${product_id}'
    
If price is not available then just show the hyphen (-) sign

# Solution:
Features: 
- Clean Swift code and strcuture
- MVVM Architecture
- FirebaseManager and Api Manager
- Async await Concurrency technique
