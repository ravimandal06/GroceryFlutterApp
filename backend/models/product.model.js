const db = require("../config/db");
const mongoose = require("mongoose");
const { Schema } = mongoose;
const UserModel = require("./user.model");

const productSchema = new Schema(
  {
    userId: {
      type: String,
    },
    productType: {
      type: String,
      required: [true, "productCategory is required"],
    },
    productName: {
      type: String,
      required: [true, "productName is required"],
    },
    productStock: {
      type: Number,
      required: [true, "productStock is required"],
    },
    productPrice: {
      type: String,
      required: [true, "productPrice is required"],
    },
    productImage: {
      type: String,
      required: [true, "productImage is required"],
    },
    productOfferPrice: {
      type: Number,
    //   required: [false, "optional"],
    },
  },
  { timestamps: true }
);

const ProductModel = mongoose.model("product", productSchema);
module.exports = ProductModel;
