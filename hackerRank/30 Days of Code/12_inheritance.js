class Student extends Person {
    /*	
    *   Class Constructor
    *   
    *   @param firstName - A string denoting the Person's first name.
    *   @param lastName - A string denoting the Person's last name.
    *   @param id - An integer denoting the Person's ID number.
    *   @param scores - An array of integers denoting the Person's test scores.
    */
    // Write your constructor here
    constructor(firstName, lastName, id, scores) {
        super(firstName, lastName, id);
        this.scores = scores;
    }
    /*	
    *   Method Name: calculate
    *   @return A character denoting the grade.
    */
    calculate() {
        const avg = this.getAverage();
        let grade = '';
        
        if (90 <= avg && avg <= 100) grade = 'O';
        else if (80 <= avg && avg < 90) grade = 'E';
        else if (70 <= avg && avg < 80) grade = 'A';
        else if (55 <= avg && avg < 70) grade = 'P';
        else if (40 <= avg && avg < 55) grade = 'D';
        else grade = 'T';
        return grade;
    }
    
    getAverage() {
        // (accumulator, currentValue)
        const sum = this.scores.reduce((sum, score) => {
            return sum + score;
        }, 0) // default value of 'sum'
        
        return sum / this.scores.length;
    }
}