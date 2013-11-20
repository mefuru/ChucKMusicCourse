// Two oscillators at once
SinOsc s => dac;
SqrOsc t => dac;

// only play s
0.5 => s.gain;
0 => t.gain;

for (0 => int i; i < 500; i++) {
    i => s.freq;
    0.001::second => now;
}

// only play t
0.2 => t.gain;
0 => s.gain;
for (0=> int i; i < 500; i++) {
    i => t.freq;
    0.001::second => now;
}

// play both at the same time
0.5 => t.gain;
0.2 => s.gain;
for (0=> int i; i < 500; i++) {
    i => t.freq;
    i*2 => s.freq;
    0.001::second => now;
}