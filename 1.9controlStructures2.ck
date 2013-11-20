SinOsc s => dac;
// for loop - sweep through frequencies
for (20 => int i; i < 400; i++) {
    <<< i >>>;
    i => s.freq;
    0.001::second => now;
}

SinOsc s2 => dac;
20 => int i;
while (i < 400) {
    i => s2.freq;
    0.001::second => now;
    i++;
}