// midi frequency. 128 different pitches built into chuck
// standard library has two built in functions
// sound chain
TriOsc s => dac;

// loop
for ( 0 => int i; i <= 127; i++) {
    Std.mtof(i) => float Hz; // method in standard library, passing in midi no  
    <<< i, Hz >>>;
    Hz => s.freq; // update freq.
    // 20::ms => now;
}

// another method in the standard library is the absolute function
// e.g std.abs(int), std.fabs(float), std.sgn(float)

-10 => int negative_int;
-1.2234 => float negative_float;

Std.abs(negative_int) => int abs_int;
Std.fabs(negative_float) => float abs_float;

<<< abs_int, abs_float >>>;

// Conversion - 8 methods. Convert types

// e.g

1=> int volume;
// midi note as a float
45.6 => float MIDI_note;


volume => float f_volume; // convert volume to float
Std.ftoi(MIDI_note) => int i_MIDI_note; // convert using Stf.ftoi
// Rounded DOWN!

<<< f_volume, i_MIDI_note >>>;