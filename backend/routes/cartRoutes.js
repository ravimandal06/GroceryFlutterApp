const express = require("express");
const router = express.Router();
const { addToCart, getUserCartList } = require("../controller/Cart_Controller");
router.post('/addToCart', addToCart);
router.get('/getUserCartList/:userId', getUserCartList);
module.exports = router;