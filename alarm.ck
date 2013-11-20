now + 5::second => time later; // will give us another time value

while (now < later) {
    //print out
    <<< "time left:",(later-now)/second >>>;
    // advance time
    1::second => now;
}

<<< "IT'S TIME!!!" >>>;

SinOsc foo => dac; // new Sine oscillator
880 => foo.freq; // set freq
2::second => now; // set duration / advance time

// chucking (=>) a duration to now advances ChucK time precisely by that
// amount - while automatically suspending your code and letting sound
// generate

// now will never move forward unless / until you manipulate it - so until
// you explicitly advance time, you are actually working at a single pt
// in time. Only generate sound when you move fwd in time

// ChucK waits until now becomes the time you want to reach

// no restrictions in the amount of time you want to advance (no -ve)