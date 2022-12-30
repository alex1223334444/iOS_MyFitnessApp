const express = require('express')
const morgan = require('morgan')
const mongoose = require('mongoose')
const Food = require('./models/meal')
const User = require('./models/user')
const app = express()
const userRoutes = require('./routes/userRoutes')
const foodRoutes = require('./routes/foodRoutes')
const dotenv = require("dotenv");
const bodyParser = require('body-parser');

dotenv.config();
const url = process.env.DBURL
mongoose.connect(url, { useNewUrlParser: true })
.then((result) =>{ 
    app.listen(3001)
    console.log('connected to db')
})
.catch((err) => console.log(err))



app.use(bodyParser.json());
app.use(express.json())
app.use(morgan('dev'))
app.use(express.json())
app.use('/users',userRoutes)
app.use('/food',foodRoutes )
app.get('/', (req, res) => {

    res.send('hello to the backend')

})

