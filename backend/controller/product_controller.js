const productService = require('../services/product_service');

exports.addProduct = async (req, res, next) => {
    // try {
    //     console.log("---> req.body -->", req.body);
    //     const { productType, productName, productPrice, productStock, productImage, productOfferPrice } = req.body;
    //     let productData = await productService.addProduct(productType, productName, productPrice, productStock, productImage, productOfferPrice);
    //     console.log("---> productData -->", productData);
    //     res.json({ status: true, success: productData });
    // } catch (err) {
    //     console.log("---> err -->", err);
    //     next(err);
    // }

    try
    {

    }catch(err)
    {
        
    }
}

exports.getProduct = async (req, res, next) => {
    try{
        const { userId } = req.body;
        let productData = await productService.getUserProductList(userId);
        res.json({ status: true, success: productData });
    } catch (err) {
        console.log("---> err -->", err);
        next(err);
    }
}

exports.deleteProduct = async (req, res, next) => {
    try{
        const { id } = req.body;
        let deletedData = await productService.deleteProduct(id);   
        res.json({ status: true, success: deletedData });

    } catch (err) {
        console.log("---> err -->", err);
        next(err);
    }
}
