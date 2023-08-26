const express = require("express");
const router = express.Router();
const {
  registerAdmin,
  loginAdmin,
  addProduct,
  getProduct,
} = require("../controller/admin_Controller");

router.post("/register", registerAdmin);
router.post("/login", loginAdmin);
router.post("/addProduct", addProduct);
router.get("/getProduct", getProduct);

module.exports = router;
