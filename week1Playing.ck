SinOsc s => dac;
TriOsc t => dac;

220 => s.freq;
0.4 => s.gain;
0 => t.gain;
1::second => now;

220 => t.freq;
0 => s.gain;
0.4 => t.gain;
1::second => now;



for (220 => int i; i < 300; i++) {
    if ((i % 2) == 0) {
        i => t.freq;
        0.03::second=>now;
    }
}

for (220 => int i; i < 300; i++) {
    if ((i % 2) == 0) {
        i => t.freq;
        0.03::second=>now;
    }
}