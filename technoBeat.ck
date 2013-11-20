// sound chain
Gain master => dac; // use master DAC
SndBuf mySound => master;
SndBuf kick => master;
SndBuf hihat => master;
SndBuf => master;

0.3 => master.gain;

me.dir() + "/audio/stereo_fx_01.wav" => mySound.read;
me.dir() + "/audio/kick_01.wav" => kick.read;
me.dir() + "/audio/hihat_01.wav" => hihat.read;
me.dir() + "/audio/snare_01.wav" => snare.read;


while (true) {
 Math.random2f(0.1, 1.0) => mySound.gain;
 Math.random2f(0.1, 1.0) => mySound.rate;   
 0 => mySound.pos;
 5::second => now;    
}