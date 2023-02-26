function processData(input) {
    // split into array 
    const toArray = input.split('\n');
    // capture shift(), parse
    const testCases = parseInt(toArray.shift());
    
    for (let i = 0; i < testCases; i++) {
        let even = ''; // 0 is counted as even
        let odd = '';
        
        for (let j = 0; j < toArray[i].length; j++) {
            char = toArray[i][j];
            (j % 2 === 0) ? even += char : odd += char;
        }
        console.log(`${even} ${odd}`);
    }
} 