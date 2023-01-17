const express = require('express');
const app = express();
const port = 3000;
const redditData = require('./data.json');
const path = require('path');

app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, '/views'));// absolute path
app.use(express.static(path.join(__dirname, '/public'))); // use executes on every request

app.listen(port, () => {
    console.log(`Listen on port ${port}`);
})

app.get('/', (req, res) => { 
    res.render('home'); // looks in /views
})

app.get('/random', (req, res) => { 
    const num = Math.floor(Math.random() * 10) + 1;
    res.render('random', {rand: num}); 
})

// app.get('/r/:subreddit', (req, res) => {
//     const { subreddit } = req.params;
//     res.render('subreddit', { subreddit });
// })

app.get('/pokemon', (req, res) => {
    const pokemon = [
        'Torchic', 'Squirtle', 'Bulbasaur', 'Charmander', 'Pidegy'
    ]
    res.render('pokemon.ejs', { pokemon });
})

app.get('/r/:subreddit', (req, res) => {
    const { subreddit } = req.params;
    const data = redditData[subreddit];

    if (data) {
        res.render('subreddit', { ...data }); // spread
    } else {
        res.send(`subreddit ${ subreddit } not found`);
    }
})