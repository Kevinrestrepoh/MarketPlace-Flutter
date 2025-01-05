const PostsModel = require('../models/posts');
const UserModel = require('../models/users');

const getPosts = async(req, res) => {
    try{
        const { posts } = req.query;

        let filter = {};
        if (posts) {
            filter = {
                $or: [
                    { title: { $regex: posts, $options: 'i' } },
                    { description: { $regex: posts, $options: 'i' } }
                ]
            };
        }

        const postsList = await PostsModel.find(filter).populate({path: "user_id", model: "users", select: "_id name avatar"});
        res.status(200).json(postsList);
    }catch(err){
        res.status(500).json({error: err.message});
    }
}

const addPost = async(req, res) => {
    try{
        const p = req.body;

        const post = new PostsModel(p);
        await post.save();

        const user = await UserModel.findById(post.user_id);
        if(!user){
            return res.status(404).json({ error: "user not found" });
        }
        user.posts.push(post._id);
        await user.save();

        res.status(201).json(post);
    }catch(err){

        res.status(400).json({error: err.message});
    }
}

const deletePost = async(req, res) => {
    try{
        const {id} = req.params;
        const post = await PostsModel.findByIdAndDelete({_id: id});
        if(post)
            res.status(200).json({message: "delete succesfully"});
        else
            res.status(404).json({message: "post not found"});
    }catch(err){
        res.status(500).json({error: err.message});
    }
}

module.exports = {
    getPosts,
    addPost,
    deletePost
}