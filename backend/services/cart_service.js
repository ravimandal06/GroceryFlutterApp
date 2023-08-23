const cartModel = require("../models/cartmodel");
class CartService{
    static async addToCart(userId, product_name, product_type, product_price,  product_quantity, product_image, product_offerPrice, product_stock, product_totalPrice, isSelectedToCart){
         // i need to add the push the data to cart if cart is already exsist for user if not create one
        try {
            console.log(userId);
            const cartList = await cartModel.findOne({ userId });
            if (cartList) {
                const product = {
                    product_name,
                    product_type,
                    product_price,
                    product_quantity,
                    product_image,
                    product_offerPrice,
                    product_stock,
                    product_totalPrice,
                    isSelectedToCart,
                   
                }
                cartList.cart_list.push(product);
                await cartList.save();
                return cartList;
            } else {
                const cartList = new cartModel({
                    userId,
                    cart_list: [{
                        product_name,
                        product_type,
                        product_price,
                        product_quantity,
                        product_image,
                        product_offerPrice,
                        product_stock,
                        product_totalPrice,
                        isSelectedToCart
                        

                    }]
                });
                await cartList.save();
                return cartList;
            }
        } catch (error) {
            return false;
        }
    }
    static async getUserCartList(userId){
        try{
            const cartList = await cartModel.findOne({userId});
            return cartList;
        }catch(error){
            return false;
        }
    }
}
module.exports = CartService;