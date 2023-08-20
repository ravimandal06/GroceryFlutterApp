const mongoose = require("mongoose");
const { Schema } = mongoose;
const cartScheme = new Schema({
    userId: {
        type: String,
        required: [true, "userId is required"],
    },
    cart_list: [
        {
            product_name:
            {
                type: String,
                required: [true, "product_name is required"],
                unique: true,
            },
            product_price: {
                type: Number,
            },
            product_quantity: {
                type: Number,
            },
            product_image: {
                type: String,
            }
            
        }
    ]
}, {
    timestamps: true,
});
module.exports = mongoose.model("cartModel", cartScheme);