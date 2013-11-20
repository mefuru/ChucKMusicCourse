// if statement

SinOsc s => dac;
220.45 => s.freq; // set freq
0.2 => s.gain; // set vol
7 => int chance; // chance variable

if (chance == 1) {
    1::second => now; // sound only plays when chance == 1
} else {
    440.32 => s.freq;
    3:: second => now;
}

// nested if

if((chance == 1) || (chance ==5)) {
 // code goes here
}
if((chance == 1) && (chance ==5)) {
    // code goes here
}