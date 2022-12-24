
/**
 * Functions
 */
function processAction(input) {
    if (input.toLowerCase() == 'add') {
        add(prompt('Task? '));
    }
    else if (input.toLowerCase() == 'list') {
        list();
    }
    else if (input.toLowerCase() == 'delete') {
        list();
        remove();
    }
    else if (input.toLowerCase() == 'undo') {
        undo();
    }
}

function getAction() {
    return prompt('Action? ');
}

function add(input) {
    taskList.push(input);
    console.log(`${input} added to list`);
}

function remove() {
    const index = parseInt(prompt('Task to delete? ')) - 1;
    if (!Number.isNaN(index) &&
    0 <= index && index <= taskList.length) {
        // splice(start, deleteCount, replace/insert)
        // stores deleted.
        const removed = taskList.splice(index, 1);
        console.log(`${removed} removed`);
    }
    else {
        console.log('Not valid task');
    }
}

function undo() {
    taskList.pop();
}

function list() {
    console.log('***************')
    for (let i = 0; i < taskList.length; i++) {
        console.log(`${i + 1}: ${taskList[i]}`);
    }
    console.log('***************')
}

// npm install prompt-sync
// comment out for browser
const prompt = require("prompt-sync")({sigint: true});

let input = "";
const taskList = ['hi', 'it\'s me', 'I\'m the problem', 'it\'s me.'];

while(input != 'quit' && input != 'q') {
    input = getAction();
    processAction(input);
}
console.log('Application exiting...');
