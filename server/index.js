const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

const userRoutes = require('./routes/userRoutes');
const postRoutes = require('./routes/postRoutes');

const app = express();
app.use(express.json());
app.use(cors());

mongoose.connect("mongodb://localhost:27017/next");

app.use("/users", userRoutes);
app.use("/posts", postRoutes);

app.listen(3001, '192.168.1.14', ()=>{
    console.log("running");
});