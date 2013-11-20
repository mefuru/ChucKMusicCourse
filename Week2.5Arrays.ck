SqrOsc s => dac;

// better way of delcaration
[54, 56, 62, 54, 48, 50, 52] @=> int A[];
[.5, .2, .4, .6, .5, .3, .4] @=> float notes[];

// array look up
// A[1] => int data;

// what does this print out
// <<< data >>>;
// 58 => A[1];

<<< A.cap() >>>; // print out no. of elems in Arr

// loop
for (0 => int i; i < A.cap(); i++) {
    <<< i, A[i] >>>;
    Std.mtof(A[i]) => s.freq;
    (notes[i]/2)::second => now;
}

// http://andymurkin.files.wordpress.com/2012/01/midi-int-midi-note-no-chart.jpg

