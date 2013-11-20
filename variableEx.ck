// sound network
SinOsc s => dac;

// declare middle c. Freq for middle c in Hz
261.63 => float myFreq;
// declare and initialise volume
0.6 => float myVol;

// set freq and volume
myFreq => s.freq;
myVol => s.gain;

1::second => now;