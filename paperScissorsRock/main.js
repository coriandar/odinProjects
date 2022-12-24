let computerScore = 0;
let playerScore = 0;
const moveSet = ['paper', 'scissors', 'rock'];

function getComputerMove() {
    // generate randomInt, floor rounds down int.
    return moveSet[Math.floor(Math.random() * moveSet.length)];
}

function result(winnerSelection, loserSelection) {
    return `${winnerSelection} beats ${loserSelection}`;
}

// 1 round test
function round(playerSelection, computerSelection) {
    if ((playerSelection == 'paper' && computerSelection == 'rock') ||
        (playerSelection == 'scissor' && computerSelection == 'paper') ||
        (playerSelection == 'rock' && computerSelection == 'scissors')) {
            console.log(`You win! ${result(playerSelection, computerSelection)}`);
            playerScore++;
    }
    else if (playerSelection == computerSelection) {
        console.log("It's a tie");
    }
    else {
        console.log(`You lose! ${result(computerSelection, playerSelection)}`);
        computerScore++;
    }
}

function game() {
    for (let i = 0; i < 5; i++) {
        // round(prompt('Your move'),getComputerMove());
        round(getComputerMove(), getComputerMove());
    }
}

console.log(game());