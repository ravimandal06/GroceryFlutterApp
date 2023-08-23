const CartService = require("../services/cart_service");
const addToCart = async (req, res) => {
    try {
        const cartdata = req.body;
        console.log(cartdata);
        const cartList = await CartService.addToCart(cartdata.userId, cartdata.product_name, cartdata.product_type, cartdata.product_price, cartdata.product_quantity, cartdata.product_image, cartdata.product_offerPrice, cartdata.product_stock, cartdata.product_totalPrice, cartdata.isSelectedToCart);
        if (cartList) {
            console.log(cartList);
            return res.status(200).json(cartList );
        }
        else { 
            return res.status(400).json({ message: "something went wrong" });
        }
    }
    catch (error) {
        return  res.status(400).json({ message: error.message });
    }
};


const getUserCartList = async (req, res) => { 
    try {
        const cartList = await CartService.getUserCartList(req.params.userId);
        if(cartList){
            return res.status(200).json(cartList);
        }
        else {
            return res.status(400).json({ message: "something went wrong" });
        }
    }
    catch(error) {
        return res.status(400).json({ message:'Error' });
    }
}
module.exports = {addToCart, getUserCartList};