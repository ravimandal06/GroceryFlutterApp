const router = require('express').Router();
const ProductController = require('../controller/product_controller');

router.post('/addProduct', ProductController.addProduct);
router.get('/getProducts', ProductController.getProduct);
router.get('/deleteProduct', ProductController.deleteProduct);

module.exports = router;