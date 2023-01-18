const express = require('express');
const app = express();
const path = require('path');
const port = 3000;
const methodOverride = require('method-override');

const Product = require('./models/product'); // import schema

const mongoose = require('mongoose');

mongoose.connect('mongodb://localhost:27017/productInventory', { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => {
        console.log("MONGO CONNECTION OPEN!!!")
    })
    .catch(err => {
        console.log("OH NO MONGO CONNECTION ERROR!!!!")
        console.log(err)
    })

app.set('views', path.join(__dirname, '/views'));
app.set('view engine', 'ejs');

// middleware
app.use(express.urlencoded({extended: true})) // allow req.body parse
app.use(methodOverride('_method'));

app.listen(port, () => {
    console.log(`Listening on port ${port}`);
})

const categories = ['fruit', 'vegetable', 'dairy'];

/** 
 * 
 * ORDER MATTERS, runs in this order
 * 
*/

// INDEX
app.get('/products', async (req, res) => {
    const { category } = req.query;
    if (category) {
        const products = await Product.find({category});
        res.render('products/index.ejs', { products, category}); // passthrough all products
    } else {
        const products = await Product.find({});
        res.render('products/index.ejs', { products, category: 'All'}); // passthrough all products
    }
})

// NEW
app.get('/products/new', (req, res) => {;
    res.render('products/new.ejs', { categories });
})

// CREATE
app.post('/products/', async (req, res) => {
    const newProduct = new Product(req.body); // no validation, keep simple
    await newProduct.save(); // can take time to save
    console.log(newProduct);
    res.redirect(`/products/${newProduct._id}`); // prevent form resubmission
})

// SHOW
// error handling required, if products/xxx, code inside will crash server
app.get('/products/:id', async (req, res) => {
    const { id } = req.params; // destructure id
    const product = await Product.findById(id);
    res.render('products/show.ejs', { product });
})

// EDIT
app.get('/products/:id/edit', async (req, res) => {;
    const { id } = req.params; // destructure id
    const product = await Product.findById(id);
    res.render('products/edit.ejs', { product, categories });
})

// UPDATE
app.put('/products/:id', async (req, res) => {
    const { id } = req.params;
    const product = await Product.findByIdAndUpdate(
        id, req.body, 
        {
            runValidators: true, // need add validation
            new: true
        }); 
    res.redirect(`/products/${product._id}`); // prevent form resubmission
})

// DELETE
app.delete('/products/:id', async (req, res) => {
    const { id } = req.params;
    const deleted = await Product.findByIdAndDelete(id);
    res.redirect('/products/');
})

// EVERTHING ELSE
// need more error handling
app.get('*', (req, res) => {
    res.send('404');
})