0.25 => float quarterNote;
30 => int melodyLength; // in seconds

// Declare Oscillators
SqrOsc q => dac; // Sharp
SinOsc s => dac; // Theme
TriOsc t => dac; // Points
SawOsc w => dac; // Base

// D Dorian scale [50, 52, 53, 55, 57, 59, 60, 62]
0.2 => t.gain;
0.1 => w.gain;
0.1 => q.gain;

[25, 30, 25, 30, 25, 30, 26, 26, 25, 30, 25, 30, 25, 30, 26, 26] @=> int Base[];
[62, 62, 62, 62, 59, 59, 59, 59, 62, 62, 62, 62, 52, 52, 52, 52] @=> int Theme[];
[50, 50, 60, 60, 0, 0, 0, 0, 50, 50, 60, 60, 0, 0, 0, 0] @=> int Points1[];
[55, 55, 55, 55, 0, 0, 0, 0, 55, 55, 55, 55, 0, 0, 0, 0] @=> int Points2[];
[0, 0, 0, 0, 124, 124, 100, 100, 0, 0, 0, 0, 124, 124, 100, 100] @=> int Sharp[];

for (0 => int j; j < melodyLength/(quarterNote*Base.cap()); j++) { // iterate over elems
    w => Pan2 p => dac;
    -1.0 => float panPos;
    Math.random2f(0.2, 0.6) => s.gain; // randomise s vol
    for (0 => int i; i < Base.cap(); i++) {
        Std.mtof(Base[i]) => w.freq;
        Std.mtof(Theme[i]) => s.freq;
        Std.mtof(Sharp[i]) => q.freq;
        if (j < 4) {
            Std.mtof(Points1[i]) => t.freq;
            <<< "Phase 1" >>>;
            0 => q.gain;
        } else {
            Std.mtof(Points2[i]) => t.freq;
            <<< "Phase 2" >>>;
            0.2 => q.gain;
        }

        for (1 => int k; k < 10; k++) {
            1/k => t.gain;
            0.025::second => now;
        }

        // quarterNote::second=>now;
        
        if (j < 8) {
            panPos + 0.25 => p.pan;
        } else {
            panPos - 0.25 => p.pan;
        }
        
    }
}