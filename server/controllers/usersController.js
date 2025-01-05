const mongoose = require('mongoose');
const UserModel = require('../models/users');

const login = async(req, res) => {
    try{
        const {email, password} = req.body;
        const user = await UserModel.findOne({email, password}).select("-password -posts");
        res.status(200).json(user);
    }catch (err){
        res.status(500).json({error: err.message});
    }
}

const getUser = async(req, res) => {
    try{
        const {id} = req.params;
        if (!mongoose.Types.ObjectId.isValid(id)) {
            return res.status(400).json({ message: "invalid user ID format" });
        }
        const user = await UserModel.findOne({_id: id}).select("-password -posts");
        if(user)
            res.status(200).json(user);
        else
            res.status(404).json({message: "user not found"});
    }catch (err){
        res.status(500).json({error: err.message});
    }
}

const getUserPosts = async(req, res) => {
    try{
        const {id} = req.params;
        const posts = await UserModel.findOne({_id: id}).populate({path:"posts", model: "posts", populate: {path: "user_id", model: "users"}}).select("posts -_id");
        res.status(200).json(posts.posts);
    }catch(err){
        res.status(500).json({error: err.message});
    }
}

const addUser = async(req, res) => {
    try{
        const user = new UserModel(req.body);
        await user.save();
        const data = user.toObject();
        delete data.password;
        delete data.posts;
        res.status(201).json(data);
    }catch(err){
        res.status(400).json({error: err.message});
    }
}

const deleteUser = async(req, res) => {
    try{
        const {id} = req.params;
        const user = await UserModel.findByIdAndDelete({_id: id});
        if(user)
            res.status(200).json({message: "delete succesfully"});
        else
            res.status(404).json({message: "user not found"});
    }catch(err){
        res.status(500).json({error: err.message});
    }
}

module.exports = {
    login,
    getUser,
    addUser,
    deleteUser,
    getUserPosts
}