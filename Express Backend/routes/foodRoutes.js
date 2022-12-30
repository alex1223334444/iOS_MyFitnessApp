const express = require('express')
const router = express.Router()
const User = require('../models/user')
const Food = require('../models/meal')

router.get('/', (req, res) => {
    Food.find()
    .then((result) => {
        res.send(result)
    })
    .catch((err) => {
        console.log(err)
    })
})

router.post('/add', (req, res) => {
    const food = new Food({
        uid: req.body.id,
        name: req.body.name,
        calories: req.body.calories,
        serving_size_g: req.body.serving_size_g,
        fat_total_g: req.body.fat_total_g,
        fat_saturated_g: req.body.fat_saturated_g,
        protein_g: req.body.protein_g,
        sodium_mg: req.body.sodium_mg,
        potassium_mg: req.body.potassium_mg,
        cholesterol_mg: req.body.cholesterol_mg,
        carbohydrates_total_g: req.body.carbohydrates_total_g,
        fiber_g: req.body.fiber_g,
        sugar_g: req.body.sugar_g,
        uid: req.body.uid
      })
    console.log(food)
    food.save()
    .then((results) => {
        console.log(results)
        res.send(results)
    })
    .catch(err => {
        res.status(400).json({ message: 'Error saving user to the database' })})
})

router.get('/:id', (req, res) => {
    Food.find({
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
