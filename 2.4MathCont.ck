// There are many Math functions within library. Sim to JS Math

// Audio panning - Spreading out instruments over L and R
// Can do this in ChucK
// ex1 - play different sounds in diff speakers
/*
SinOsc s => dac.left; // set s to left speaker
SinOsc t => dac.right; // set t to right

220 => s.freq;
330 => t.freq;

0.2::second => now;
*/
// ex.2 - diff channels
/*
SinOsc s => dac.chan(0);
SinOsc t => dac.chan(1);
SinOsc u => dac.chan(2);
SinOsc v => dac.chan(3);
*/

// ex3 - move sound from one side to the other


// SinOsc s => Pan2 p => dac;
// -1 on one side, 1 on the other
/*

1.0 => float panPos;
while (panPos > -1.0) {
    panPos => p.pan;
    <<< panPos >>>;
    panPos - 0.01 => panPos;
    0.01::second => now;
}
*/

// ex 4 sound chain
Noise n => Pan2 p => dac;

while (true) {
    Math.sin(now/1::second*2*pi) => p.pan; // UGen
    10::ms;
}