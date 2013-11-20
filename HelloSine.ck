// sound network should always be at the top
SinOsc s => dac; // sine oscillator s chucked to digital audio conv
<<< "Hello Sine!" >>>; // Write to console
// note 1
0.6 => s.gain; // control volume
220 => s.freq; // frequency (Hz) Human hearing btw 20-20k
1::second => now; // play for one second
// note 2
0.5 => s.gain;
440 => s.freq;
2:: second => now;
// note 3
0.3 => s.gain;
330 => s.freq;
3:: second => now;
/* Sine osciallator is the most basic
Squarewave (SqrOsc s => dac). Gritty
Triange wave, TriOsc
Sawtooth, SawOsc. Very rich sound. Partials
Recommend playing around with just the one to begin with
*/