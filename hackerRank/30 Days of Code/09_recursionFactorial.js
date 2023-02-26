function factorial(n) {
    if (n >= 1) {
        // (n - 1) reduces n each time
        return n * factorial(n - 1);
    }
    else {
        return 1; // base case
    }
}