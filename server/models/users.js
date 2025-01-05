const mongoose = require('mongoose');
const UserSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    email: {
        type: String,
        required: true
    },
    password: {
        type: String,
        requierd: true,
    },
    phone: {
        type: Number,
        required: true
    },
    avatar: {
        type: String,
        requierd: false
    },
    posts: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: "posts",
        requierd: false
    }]
}, {versionKey: false});

const UserModel = mongoose.model("users", UserSchema);
module.exports = UserModel;