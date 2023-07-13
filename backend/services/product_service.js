const {deletedData} = require('../controller/product_controller');
const ProductModel = require('../models/product.model');

class ProductService{
    static async addProduct(productType, productName, productPrice, productStock, productImage, productOfferPrice){

        
            const productData = new ProductModel({productType, productName, productPrice, productStock, productImage, productOfferPrice});
            return await productData.save();
        
    }

    static async getUserProductList(userId){
       
            const productList =  await ProductModel.find({userId});
            return productList;
       
    
    }
    static async deleteProduct(id){
       
            const deleted = await ProductModel.findByIdAndDelete({_id:id});
            return deleted;
        
    }
}

module.exports = ProductService;