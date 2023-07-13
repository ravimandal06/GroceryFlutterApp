const mongoose = require('mongoose');

const connection = mongoose.createConnection('mongodb+srv://vendor:ravi123@cluster0.jme12.mongodb.net/?retryWrites=true&w=majority').on('open', ()=>{console.log('MongoDB Connected');}).on('error', ()=>{console.log('MongoDB Connection error');});

module.exports = connection;