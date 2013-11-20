// How to reverse a sample. We put the position at the end
// And make the rate a -ve number!

// soundchain
SndBuf mySound => dac;

me.dir() + "/audio/snare_01.wav" => string filename;
// open soundfile
filename => mySound.read;
// similar to capacity of an array. Find no. of samples
mySound.samples() => int numSamples;

while (true) {
 numSamples => mySound.pos; // set playhead pos
 -1.0 => mySound.rate;
 1::second => now;   
}