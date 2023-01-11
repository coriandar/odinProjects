// TODO:
// between numbers
// max load

const container = document.querySelector('#container');
const baseURL ='https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/'

// let start = document.querySelector('input[name="start"]').value;
// console.log(start)

// loop error without parseInt, need sanitise
let min = parseInt(prompt("min#:"));
let max = parseInt(prompt("max#: "));

if (min > max) {
    min = 1;
}

if (max > 151) {
    max = 151;
}

for (let i = min; i <= max; i++){
    const pokemon = document.createElement('img');
    pokemon.src = `${baseURL}${i}.png`;
    container.append(pokemon);
}