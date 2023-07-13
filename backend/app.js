const express = require('express');
const bodyParser = require('body-parser');
const UserRouter = require('./routes/user.routes');
const ProductRouter = require('./routes/addProduct.routes');

const app = express();

app.use(bodyParser.json());
app.use('/', UserRouter);
app.use('/', ProductRouter);

module.exports = app;