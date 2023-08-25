const express = require("express");
const router = express.Router();
const { addToCart, getUserCartList, deleteCart } = require("../controller/Cart_Controller");
router.post('/addToCart', addToCart);
router.get('/getUserCartList/:userId', getUserCartList);
router.delete('/deleteCart/:userId/:productId', deleteCart); 
module.exports = router;