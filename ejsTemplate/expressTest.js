const express = require('express');
const { redirect } = require('express/lib/response');
const res = require('express/lib/response');
const port = 3000; // localhost:3000
const app = express();

/** one response per http request */
// app.use((request, response) => { // all incoming request, i.e refersh browser
//     console.log('Got a new request');
//     // response.send('Request received successfully');
//     response.send('<h1>H1 Heading</h1>');
// })
app.get('/', (req, res) => {
    res.send('Home page');
})

// anything after /r/ will be a subreddit
app.get('/r/:subreddit', (req, res) => {
    // console.log(req.params);
    const { subreddit } = req.params; // destructure
    res.send(`Browsing ${subreddit}`);
})

app.get('/r/:subreddit/:postID', (req, res) => {
    // console.log(req.params);
    const { subreddit, postID } = req.params; // destructure
    res.send(`Subreddit: ${subreddit}, PostID: ${postID}`);
})

app.get('/cats', (req, res) => {
    console.log('Cat requests');
    res.send('Meow');
})

app.get('/dogs', (req, res) => {
    res.send('Woof');
})

app.get('/search', (req, res) => {
    console.log(req.query);
    const { q } = req.query;
    res.send(`<h1>Search for ${q}</h1>`);
})

// place as last get, runs line by line
app.get('*', (req, res) => {
    res.send(`idk path`);
})

app.post('/cats', (req, res) => {
    res.send('Post request to cats');
})

app.listen(port, () => {
    console.log(`Listen on port ${port}`);
})