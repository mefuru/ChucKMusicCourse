// Randomness/Random numbers
// Compositions won't sound the same

// Math.random() random int
// Math.random2(int min, int max) random between 2 ints
// Math.randomf (random float between 0 and 1.0)
// Math.random2f

/*
while (true) {
    Math.random2(15, 20) => int i; // generate random no
    <<< i >>>;
    0.5::second => now;
    Math.randomf() => float f; // generate random no
    <<< f >>>;
    0.5::second => now;   
}
*/

SqrOsc s => dac;
Math.srandom(134); // set seed. Random sequence will be the same everytime

while (true) {
    Math.random2(20, 500) => int i; // random int
    Math.random2f(0.2, 0.9) => float v; // random vol
    <<< i, v >>>;
    i => s.freq;
    v => s.gain;
    0.5::second => now;
}

