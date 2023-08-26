const { deletedData } = require("../controller/product_controller");
const ProductModel = require("../models/product.model");

class ProductService {
  static async addProduct(
    productType,
    productName,
    productPrice,
    productStock,
    productImage,
    productOfferPrice
  ) {
    const productData = new ProductModel({
      productType,
      productName,
      productPrice,
      productStock,
      productImage,
      productOfferPrice,
    });
    return await productData.save();
  }

  static async getUserProductList(userId) {
    const productList = await ProductModel.find({ userId });
    return productList;
  }
  static async deleteProduct(id) {
    try {
      const existingProduct = await ProductModel.findById(id);

      if (!existingProduct) {
        console.log("Product not found for deletion");
        return null; // Or throw an error if preferred
      }

      const deletedProduct = await ProductModel.findByIdAndDelete(id);
      return deletedProduct;
    } catch (error) {
      throw error;
    }
  }
}

module.exports = ProductService;
