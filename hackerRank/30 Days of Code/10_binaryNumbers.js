function main() {
    const n = parseInt(readLine().trim(), 10);
    // radix of 2(bin)
    // >>> convert to un-signed 32-bit int
    const binary = (n >>> 0).toString(2);    
    
    let temp = 0;
    let max = 0;
    
    for (let i = 0; i < binary.length; i++) {
        if (binary[i] === '0') temp = 0;
        else temp++;
        if (temp > max) max = temp;
    }
    console.log(max);
}