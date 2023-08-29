const express = require("express");
const router = express.Router();
const {
  registerAdmin,
  loginAdmin,
  addProduct,
  getProducts,
  deleteProduct
} = require("../controller/admin_Controller");

router.post("/register", registerAdmin);
router.post("/login", loginAdmin);
router.post("/addProduct/:adminId", addProduct);
router.get("/getProduct/:city", getProducts);
router.delete("/deleteProduct/:id", deleteProduct);

module.exports = router;
