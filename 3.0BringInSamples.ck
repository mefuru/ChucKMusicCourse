// 3.1 Intro
// 3.2 Sound File Setup. Needed to use samples. Only use these samples
// 3.3 Samples and sound files. Sound files are represented by an array of numbers
// These arrays are called soundbufs. Souundbufs have positions
// 3.4 SoundBuf
SndBuf mySound => dac;
//directory of this file
me.dir() => string path;
// define the filename
"/audio/snare_01.wav" => string filename;
path + filename => filename;
// open up soundfile
filename => mySound.read;
// simple control
0.5 => mySound.gain; // set vol of mySound
0 => mySound.pos; // sets playhead position
1.8 => mySound.rate; // rate determines the speed that the play head will over the array
1::second => now;

