const mongoose = require('mongoose')

const Schema = mongoose.Schema

const mealSchema = new Schema({
    uid: {
        type: String,
        required : true
    },
    name: {
        type: String,
        required : true
    },
    calories: {
        type: Number,
        required : true
    },
    serving_size_g: {
        type: Number,
        required : true
    },
    fat_total_g: {
        type: Number,
        required : true
    },
    fat_saturated_g: {
        type: Number,
        required : true
    },
    protein_g: {
        type: Number,
        required : true
    },
    sodium_mg: {
        type: Number,
        required : true
    },
    potassium_mg: {
        type: Number,
        required : true
    },
    cholesterol_mg: {
        type: Number,
        required : true
    },
    carbohydrates_total_g: {
        type: Number,
        required : true
    },
    fiber_g: {
        type: Number,
        required : true
    },
    sugar_g: {
        type: Number,
        required : true
    },
},{timestamps: true})

 const Food = mongoose.model('Food', mealSchema)

 module.exports = Food