const fetchJoke = document.querySelector('#fetchJoke');
const jokeList = document.querySelector('.jokeList');

const getDadJoke = async () => {
    try {
        const config = { headers: {Accept: 'application/json'} };
        const res = await axios.get('https://icanhazdadjoke.com/', config);
        return res.data.joke;
    } catch (e) {
        return 'Nope';
    }
}

const addJoke = async () => {
    const jokeText = await getDadJoke();
    const newLI = document.createElement('li');
    newLI.append(jokeText);
    jokeList.append(newLI);
}

/* Longer syntax */
// fetchJoke.addEventListener('click', () => {
//     addJoke();
// })

/* on load it calls */
// fetchJoke.addEventListener('click', addJoke());

/* calls on click only */
fetchJoke.addEventListener('click', addJoke);