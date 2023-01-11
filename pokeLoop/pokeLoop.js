// TODO:
// add name
// make live form
// let start = document.querySelector('input[name="start"]').value;
// console.log(start)

function populatePokedex() {
    // loop error without parseInt, need sanitise
    let min = parseInt(prompt("min#:"));
    let max = parseInt(prompt("max#: "));

    if (min > max) {
        min = 1;
    }
    if (max > 151) {
        max = 151;
    }

    addPokedexEntry(min, max);
}

function addPokedexEntry(min, max) {
    const container = document.querySelector('#container');
    const baseURL ='https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/'

    for (let i = min; i <= max; i++){
        const pokemon = document.createElement('div');
        const label = document.createElement('span');
        const img = document.createElement('img');
    
        pokemon.classList.add('pokemon');
        label.innerText = `#${i}`;
        img.src = `${baseURL}${i}.png`;

        pokemon.appendChild(img);
        pokemon.appendChild(label);
        container.appendChild(pokemon);
    }
}

populatePokedex();

/*
<section>
    <div>
        <img></img>
        <span>i</span>
    </div> 
    <div>
        <img></img>
        <span>i</span>
    </div> 
</section>
*/