const express = require('express')
const router = express.Router()
const User = require('../models/user')

router.get('/', (req, res) => {
    User.find()
    .then((result) => {
        res.send(result)
    })
    .catch((err) => {
        console.log(err)
    })
})

router.post('/create', (req, res) => {
    const user = new User({
        firstName: req.body.first_name,
        lastName: req.body.last_name,
        username: req.body.username,
        phone: req.body.phone,
        uid: req.body.uid
      })
    console.log(user)
    user.save()
    .then((results) => {
        console.log(results)
        res.send(results)
    })
    .catch(err => {
        res.status(400).json({ message: 'Error saving user to the database' })})
})

router.get('/user/:id', (req, res) => {
    User.find({
        uid : req.params.id
    })
    .then((result) => {
        res.send(result)
    })
    .catch((err) => {
        console.log(err)
    })
})

module.exports = router
