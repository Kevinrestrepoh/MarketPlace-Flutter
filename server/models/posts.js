const mongoose = require('mongoose');
const PostsSchema = new mongoose.Schema({
    user_id:{
        type: mongoose.Schema.Types.ObjectId,
        ref: "users",
        required: true
    },
    title: {
        type: String,
        required: true
    },
    description: {
        type: String,
        required: true
    },
    price: {
        type: Number,
        required: true
    },
    images: [{
        type: String,
        required: false
    }]
}, {versionKey: false});

const PostsModel = mongoose.model("posts", PostsSchema);
module.exports = PostsModel;