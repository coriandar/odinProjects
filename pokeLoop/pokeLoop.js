// TODO:
// get value from form
function populatePokedex () {
    const pokemonName = ['Bulbasaur', 'Ivysaur', 'Venusaur', 
                    'Charmandar', 'Charmeleon', 'Charizard',
                    'Squirtle', 'Wartortle', 'Blastoise',
                    'Caterpie', 'Metapod', 'Butterfree'];

    let min = parseInt(document.querySelector('input[name="min"]').value);
    let max = parseInt(document.querySelector('input[name="max"]').value);

    if (isNaN(min)) {
        min = 1;
    }
    if (isNaN(max)) {
        max = 10;
    }
    if (min > max) {
        min = 1;
    }
    if (max > 151) {
        max = 151;
    }

    const container = document.querySelector('#container');
    const baseURL ='https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/'

    for (let i = min; i <= max; i++){
        const pokemon = document.createElement('div');
        const label = document.createElement('span');
        const img = document.createElement('img');

        pokemon.classList.add('pokemon');
        label.innerText = `#${i}`;
        label.innerText += `\n${pokemonName[i-1]}`;
        img.src = `${baseURL}${i}.png`;

        pokemon.appendChild(img);
        pokemon.appendChild(label);
        container.appendChild(pokemon);
    }
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
}

const showPokemon = document.querySelector('button');

showPokemon.addEventListener('click', function() {
    populatePokedex()
});