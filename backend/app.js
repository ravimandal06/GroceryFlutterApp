const express = require("express");
require("dotenv").config();
const mongoose = require("mongoose");
const { connect } = require("mongoose");
const bodyParser = require("body-parser");
const UserRouter = require("./routes/user.routes");
const ProductRouter = require("./routes/addProduct.routes");
const adminRoutes = require("./routes/admin_routes");
const app = express();

app.use(bodyParser.json());
app.use("/admin", adminRoutes);
// app.use("/", UserRouter);
// app.use("/", ProductRouter);

const port = process.env.PORT || 3000;
app.listen(process.env.PORT, () => {
  console.log(`Server is running on Port ${port}`);
  connect(process.env.mongodb_url)
    .then(() => {
      console.log("MongoDB connected");
    })
    .catch((err) => {
      console.log("DB didn't connect");
    });
});
module.exports = app;
