// Time in ChucK

// time and dur are native types, like int and float
// can declare variables to store these values, can perform arithmetic on them
// time is a point in time and dur is a length of time
// default durations: samp, ms, second, minute, hour, day, week
// not is a special time variable. now is at the heart of Chuck
// when you read now, you get the current ChucK time

<<< "now", now >>>; // outputs internal representation of time re VM
<<< "now (in seconds)", now / second >>>; // time since VM started

// can change the variable now, incrememnt now by three seconds
// also waits three seconds
3::second => now;
<<< "NEW now (in seconds)", now / second >>>; // will be printed 3s later

SinOsc foo => dac;

while(true) {
    Math.random2f(30, 1000) => foo.freq;
    250::ms => now;
}
