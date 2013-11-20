// sound chain
// stereo
SndBuf2 mySound => dac;

// read the file into string
me.dir() + "/audio/stereo_fx_01.wav" => string filename;
// open up soundfile
filename => mySound.read;

// infinitie loop
while(true) {
 Math.random2f(0.1, 1.0) => mySound.gain;
 Math.random2f(0.2, 1.8) => mySound.rate;
 0 => mySound.pos;
 5::second => now;   
}