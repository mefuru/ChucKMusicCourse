SndBuf mySound => Pan2 p => dac; // initialise a SndBuf and chuck in a pan
//directory of this file
me.dir() => string path;
// define the filename
"/audio/snare_01.wav" => string filename;
path + filename => filename;
// open up soundfile
filename => mySound.read;

while (true) {
    Math.random2f(0.2, 0.8) => mySound.gain; // randomize snare vol
    Math.random2f(0.2, 1.8) => mySound.rate;
    Math.random2f(-1.0, 1.0) => p.pan;
    0 => mySound.pos; // set play head position back to the start
    100::ms => now;
}
