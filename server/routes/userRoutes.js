const express = require('express');
const router = express.Router();
const {login, getUser, addUser, deleteUser, getUserPosts} = require('../controllers/usersController')

router.post("/login", login);
router.get("/:id", getUser);
router.get("/posts/:id", getUserPosts)
router.post("", addUser);
router.delete("/:id", deleteUser);

module.exports = router;