1 => dac.gain; // reset dac to full volume just in case

// set up my sound network
Gain drums => dac;
SndBuf kick => drums;
SndBuf snare => drums;
SndBuf snare2 => drums;
SndBuf hihat => Pan2 hihat_pan => dac;
SndBuf drone => dac;
SndBuf fx => dac;
SqrOsc sqr => dac;
SinOsc sin => dac;
SawOsc saw => NRev saw_rev => Pan2 saw_pan  => dac;
SawOsc saw2 => NRev saw2_rev => Pan2 saw2_pan => dac;
SinOsc chord => Gain chord_gain => NRev chord_rev => dac;
SinOsc chord2 => chord_gain;
SawOsc mod => SinOsc chord3 => chord_gain;
SndBuf kickdrop => Pan2 kickdrop_pan => dac;
SndBuf fx2 => Pan2 fx2_pan => dac;
SndBuf fx2_wet => NRev fx2_rev => Pan2 fx2_wet_pan => dac;
Noise noise => NRev noise_rev => Pan2 noise_pan =>  dac;

// set fx sound and rev pan
.3 => fx2_pan.pan;
-.3 => fx2_wet_pan.pan;


// set some durations
.25::second => dur quarternote;  // .25::second rule..
quarternote/16 => dur time_grain;



Std.srand(152); // seed


// set some levels
.5 => drums.gain;
.6 => kick.gain;
.32 => float sqr_gain;
.06 => saw.gain;
.06 => saw2.gain;
.02 => chord_gain.gain;
.7 => chord3.gain;
.00 => chord_rev.mix;
0.6 => fx2_wet.gain;
0.0 => noise.gain;
0.3 => noise_rev.mix;

0.09 => saw_rev.mix;
0.09 => saw2_rev.mix;

["/audio/kick_04.wav",    // Array of files
"/audio/clap_01.wav" ,
"/audio/snare_02.wav",      
"/audio/hihat_02.wav",
"/audio/stereo_fx_04.wav" ]
@=> string drumfiles[];

me.dir() => string path;
path + drumfiles[0] => kick.read;
path + drumfiles[1] => snare.read;
path + drumfiles[2] => snare2.read;
path + drumfiles[3] => hihat.read;
path + drumfiles[4] => fx2.read;
path + drumfiles[4] => fx2_wet.read;
path + "/audio/stereo_fx_05.wav" => drone.read;
path + "/audio/stereo_fx_02.wav" => fx.read;
path + "/audio/kick_04.wav" => kickdrop.read;

kick.samples() => kick.pos;   // Make sure they don't play on start
snare.samples() => snare.pos;
snare2.samples() => snare2.pos;
hihat.samples() => hihat.pos;
drone.samples() => drone.pos;
fx.samples() => fx.pos;
kickdrop.samples() => kickdrop.pos;
fx2.samples() => fx2.pos;
fx2_wet.samples() => fx2_wet.pos; 

0.65 => float hihat_gain;

// Here are my sequences. Usually 1 is on, 0 off. Usually...
// Some of these are changed in later on, but I left em here
// as well so I have the originals no matter what I do later

[ 1, 0, 0, 0,  1, 0, 0, 0,  1, 0, 0, 0,  1, 0, 1, 0,
1, 0, 0, 0,  1, 0, 0, 0,  1, 0, 0, 1,  1, 3, 0, 0 ]
@=> int kick_pattern[];

[ 0, 1, 2, 1,  0, 1, 2, 1,  0, 1, 2, 1,  0, 1, 2, 1,  
0, 1, 2, 1,  0, 1, 2, 1,  1, 1, 2, 1,  0, 1, 2, 1 ]
@=> int hihat_pattern[];

[ 0, 0, 0, 0,  1, 0, 0, 0,  0, 0, 0, 0,  1, 0, 0, 0,
0, 0, 0, 0,  1, 0, 0, 0,  0, 0, 3, 0,  1, 0, 0, 0 ] 
@=> int snare_pattern[];

[ 0, 0, 0, 0,  0, 0, 0, 0,  0, 0, 0, 0,  0, 0, 0, 0,
0, 0, 0, 0,  0, 0, 0, 0,  0, 0, 0, 0,  0, 0, 0, 1 ] 
@=> int snare2_pattern[];

[ 0, 0, 0, 0,  0, 0, 0, 0,  0, 0, 0, 0,  0, 0, 1, 0,
0, 0, 0, 0,  0, 0, 0, 0,  0, 0, 0, 0,  0, 0, 0, 0 ] 
@=> int drone_pattern[];   

[ 0, 0, 0, 0,  0, 0, 0, 0,  0, 0, 0, 2,  0, 1, 0, 0,
0, 0, 0, 0,  0, 0, 0, 3,  0, 0, 0, 0,  0, 0, 0, 0 ] 
@=> int fx_pattern[];      

[ 0, 0, 0,26,  0, 0,26, 0,  0, 0,26, 0,  0, 0, 0,26,
0, 0, 0,28,  0, 0,28, 0,  0,28, 0,26,  0, 0,38, 0 ]  
@=> int bass_pattern[];

[ 0, 1, 2, 0,  0, 0, 0, 1,  2, 0, 0, 0,  1, 0, 2, 1,
0, 2, 1, 0,  1, 2, 0, 1,  2, 1, 2, 0,  0, 0, 0, 0 ] 
@=> int synth_pattern[];

[ 50, 52, 53, 55, 57, 59, 60, 62 ]  
@=> int synth_notes[];

[ 0, 0, 0, 0,  0, 0, 0, 1,  0, 0, 8, 0,  0, 0, 0, 0,
0, 0, 0, 0,  0, 0, 0, 0,  0, 0, 0, 0,  0, 0, 0, 0 ]  
@=> int chord_pattern[];

/* Main loop coming up. Counter to create beats, and
measure was created to toggle 0 and 1 each time the 
sequence rounds, to add variation to my if thens */
0 => int counter;
0 => int measure;
while ( true )
{
    // noise crash
    if ( counter == 128 )
    {
        .07 => noise.gain;
    }
    
    if ( counter > 128 )
    {
        
        if (    (noise.gain() > 0)    &&    (Math.sgn(noise.gain()) == 1))
        {
            
            noise.gain() - (.008) => noise.gain;
            Math.random2f(-0.4, 0.4) => noise_pan.pan;
            
        }
        
    }
    
    
    // keep certain sounds from playing in beginning
    // build up basically...
    if ( counter == 0 )
    {
        sin =< dac;
        kick =< drums;
        snare =< drums;
        snare2 =< drums;
        hihat =< hihat_pan;
        
    }
    else if ( counter == 90 )
    {
        fx2.samples() => fx2.pos;
        -1.725 => fx2.rate;
        fx2_wet.samples() => fx2_wet.pos;
        -1.71 => fx2_wet.rate;
    }
    else if ( counter == 32 )
    {
        sin => dac;
    }
    else if ( counter == 64 )
    {
        kick => drums;
        
    }
    else if ( counter < 120 ) // beginning synth pattern
    {
        
        [ 0, 1, 2, 0,  0, 0, 0, 1,  2, 0, 0, 0,  0, 0, 2, 0,
        0, 2, 0, 0,  0, 2, 0, 0,  2, 0, 2, 0,  0, 0, 0, 0 ] 
        @=> synth_pattern;
    }
    else if ( counter == 125 )
    {
        hihat => hihat_pan;
        0 => fx2.pos;
        0 => fx2.rate;
        0 => fx2_wet.pos;
        0 => fx2_wet.rate;
    }
    else if ( counter == 132 )
    {
        snare => drums;
        snare2 => drums;
        // this synth pattern plays for the rest of the song
        [ 0, 1, 2, 0,  0, 0, 0, 1,  2, 0, 0, 0,  1, 0, 2, 1,
        0, 2, 1, 0,  1, 2, 0, 1,  2, 1, 2, 0,  0, 0, 0, 0 ] 
        @=> synth_pattern;
    }
    
    if ( counter == 224 )
    {
        // this changes up the bass
        [ 0, 0, 0,28,  0, 0,28, 0,  0, 0,28, 0,  0, 0, 0,28,
        0, 0, 0,26,  0, 0,29, 0,  0,26, 0,26,  24, 26,26, 0 ]  
        @=> bass_pattern;
    }
    // create 32 beat sequencer
    counter % 32 => int beat;
    // this sets measure to alternate 0 and 1 and change chord 
    if ( beat == 31 )
    {
        measure++;
    }
    if (measure > 1 ) 
    {
        0 => measure;
    }
    //play kick normal
    if ( kick_pattern[beat] == 1 )
    {
        0 => kick.pos;
        1 => kick.rate;
    }
    //play kick reversed
    else if ( kick_pattern[beat] == 3 )
    {
        9000 => kick.pos;
        -.5 => kick.rate;
    }
    
    /*------hihat pattern-----------------------------------------------*/
    
    if ( hihat_pattern[beat] == 1 )
    {
        (hihat_gain - 0.45)-Math.random2f(0, 0.2) => hihat.gain;
        Math.random2f(-0.3, 0.3) => hihat_pan.pan;
        1200 => hihat.pos;
    }
    else if ( hihat_pattern[beat] == 2 )
    {
        hihat_gain => hihat.gain;
        0 => hihat_pan.pan;
        600 => hihat.pos;
    }
    
    /*------snare pattern-------------------------------------------------*/
    
    if ( snare_pattern[beat] == 1 )
    { 
        0 => snare.pos;
        0.95 => snare.rate;
        1 => snare.gain;
    }
    else if ( snare_pattern[beat] == 3 )
    { 
        6500 => snare.pos;
        -0.95 => snare.rate;
        .5 => snare.gain;
    }
    
    /*------other snare----------------------------------------------------*/
    
    
    if ( snare2_pattern[beat] == 1 )
    { 
        0 => snare2.pos;
        0.95 => snare2.rate;
        1 => snare2.gain;
    } 
    
    /*-------drone sound----------------------------------------------------*/
    
    if ( drone_pattern[beat] == 1 )
    {
        10000 => drone.pos;
        0.2450 => drone.rate;
    }
    else
    {
        drone.samples() => drone.pos;
    }
    
    /*-------fx sounds-------------------------------------------------------*/
    if (measure == 0)
    {
        if ( fx_pattern[beat] == 1 )
        {
            40000 => fx.pos;
            1.1 => fx.rate;
            0.5 => fx.gain;
        }
        else if ( fx_pattern[beat] == 2 )
        {
            40000 => fx.pos;
            3 => fx.rate;
            0.4 => fx.gain;
        }
        else if ( fx_pattern[beat] == 3 )
        {
            40000 => fx.pos;
            1.9 => fx.rate;
            0.4 => fx.gain;
        }
        else   
        {
            fx.samples() => fx.pos;
        }
    }
    else
    {
        if ( fx_pattern[beat] == 3 )
        {
            40000 => fx.pos;
            1.1 => fx.rate;
            0.5 => fx.gain;
        }
        else if ( fx_pattern[beat] == 1 )
        {
            40000 => fx.pos;
            3 => fx.rate;
            0.4 => fx.gain;
        }
        else if ( fx_pattern[beat] == 2 )
        {
            40000 => fx.pos;
            1.9 => fx.rate;
            0.4 => fx.gain;
        }
        else   
        {
            fx.samples() => fx.pos;
        }
    }
    
    
    /*-------bass--------------------------------------------------------*/
    
    if ( bass_pattern[beat] > 0 )
    {
        Std.mtof(bass_pattern[beat]) => sqr.freq;
        Math.random2(0, 3) => int choose;
        if (choose == 2)
        {
            Std.mtof(bass_pattern[beat])*2  => sin.freq;
        }
        else if (choose == 1)
        {
            
        } 
        else
        {
            Std.mtof(bass_pattern[beat])  => sin.freq;
        }
        
        if ( beat == 30 )
        {
            sqr_gain - .12 => sqr.gain;
            sqr_gain - .05 => sin.gain;
            
        }
        else
        {
            sqr_gain-.15 => sqr.gain;
            sqr_gain - .10=> sin.gain;
        }
    }
    else
    {
        0 => sqr.gain;
        0 => sin.gain;
    }
    
    /*-------synth rules----------------------------------------------------*/
    
    if ( synth_pattern[beat] == 1 )
    {
        Math.random2f(-1,1) => float saw_pan_rand;
        
        if ( Math.random2(0,1) == 1 )
        {
            (saw_pan_rand)*(-1) => saw_pan.pan;
            (saw_pan_rand) => saw2_pan.pan;
            Math.random2(0,7) => int temp_pitch;
            Std.mtof( synth_notes[temp_pitch] -.2 ) => saw.freq;
            Std.mtof( synth_notes[temp_pitch] +.2 ) => saw2.freq;
        }
        else
        {
            (saw_pan_rand)*(-1) => saw2_pan.pan;
            (saw_pan_rand) => saw_pan.pan;
            Math.random2(0,7) => int temp_pitch;
            Std.mtof( synth_notes[temp_pitch] + 11.9) => saw.freq;
            Std.mtof( synth_notes[temp_pitch] + 12.1) => saw2.freq;
        }
        .06 => saw.gain;
        .06 => saw2.gain;
    }
    else if ( synth_pattern[beat] == 2 )
    {
        0 => saw.gain;
        0 => saw2.gain;
    }
    
    /*------chord rules------------------------------------------------------*/
    
    if (measure == 0)
    {
        if ( chord_pattern[beat] == 1 )
        {
            Std.mtof(50) => chord.freq;
            Std.mtof(53) => chord2.freq;
            Std.mtof(57) => chord3.freq;
            0.09 => chord_gain.gain; 
            0.1 => chord_rev.mix;
            0 => mod.gain;
            
        }
        else if ( chord_pattern[beat] == 8 )
        {
            0.00 => chord_rev.mix;    
        }
        else
        {
            0.00 => chord_gain.gain;
        }
    }
    else
    {
        if ( chord_pattern[beat] == 1 )
        {
            Std.mtof(67) => chord.freq;
            Std.mtof(55) => chord2.freq;
            Std.mtof(62) => chord3.freq;
            0.09 => chord_gain.gain; 
            0.1 => chord_rev.mix;
            5 => mod.freq;
            330 => mod.gain;
            2 => chord3.sync;
        }
        else if ( chord_pattern[beat] == 8 )
        {
            0.00 => chord_rev.mix;    
        }
        else
        {
            0.00 => chord_gain.gain;
        }
        
        
        
    }
    
    /*------------------------------------------------------------------*/
    
    
    
    
    // this is where time is advanceed
    if ( (beat % 2) == 0 )
    {
        
        9::time_grain => now;
        if ( beat < 16 )
        {
            .00=> saw.gain;
            .00 => saw2.gain;
        }
        1::time_grain => now;
    }
    else
    {
        4::time_grain => now;
        if ( beat < 16 )
        {
            .00=> saw.gain;
            .00 => saw2.gain;
        }
        2::time_grain => now;
    }       
    
    
    counter++;
    
    //this is the ending note
    if ( counter == 256 )
    {
        0 => kick.pos;
        0.8 => kick.gain;
        1 => kick.rate;
        /*.940*/0.5625 => fx.rate;
        0.2 => fx.gain;
        270000 => fx.pos;
        
        /*1.25*/1.5 => fx2.rate;
        0.4 => fx2.gain;
        300000 => fx2.pos;
        0 => noise.gain;
        
        6::second => now;
        
        
        
        
        break;
    } 
    
    counter % wav.cap() => wav_beat;
    if ( counter < 242 )
    {
        <<< wav[wav_beat] >>>; 
    }
    else if ( counter == 242 )
    {
        <<< wav[11] >>>;
    }
    else if ( counter == 243 )
    {
        <<<"                                  ">>>;
        <<<"                                  ">>>;
        <<<"                                  ">>>;
        <<<"               FIN                ">>>;
    }
    
    
    
}

1 => dac.gain;


4
 flag



Laurens ROD 7 days ago 
Thank you very much, it didn't ocurred to me to use an oscilator to control the gain of another oscilator 
Mine is simpler: 

<<< "Assignment_3_EX_Beats.ck" >>>;

// Sound system
SawOsc oscChip => Pan2 pc => dac;
SinOsc oscBass => dac;
TriOsc oscSong => dac;

// Samples used
string samples[3];
me.dir() + "/audio/kick_05.wav" => samples[0];
me.dir() + "/audio/hihat_02.wav" => samples[1];
me.dir() + "/audio/snare_02.wav" => samples[2];

Gain master => dac;
SndBuf kick => master;
SndBuf snare => master;
SndBuf hihat => master;

// Setting samples
samples[0] => kick.read;
0.35 => kick.gain;
kick.samples() => kick.pos;

samples[1] => hihat.read;
0.1 => hihat.gain;
hihat.samples() => hihat.pos;

samples[2] => snare.read;
0.15 => snare.gain;
snare.samples() => snare.pos;

// Muting all
0 => oscChip.gain;
0 => oscBass.gain;
0 => oscSong.gain;

// Allowed notes
[50, 52, 53, 55, 57, 59, 60, 62] @=> int notes[];

// Melodies
[-1, -1, 0, 1, 0, 1, 3, 2, 5, 6, -1, 5, 6, -1, 4, 7, 
-1, -1, 0, 1, 0, 1, 3, 2, 5, 6, -1, 4, 7, -1, 3, 0 ] @=> int chip[];

[0, -1, -1, -1, 2, -1, -1, -1, 0, -1, -1, -1, 3, -1, -1, -1] @=> int bass[];

0.05 => float VC;
0.2 => float VS;
0.35 => float VB;

0 => int kc; // Index chip pattern
0 => int kb; // Index bass pattern
0 => int ks;

// Set the times
now + 30::second => time timeEnd;
now => time timeStart;
0 => float t;

// The random 'song' generator.
Math.srandom( 1 );

0 => float freq;
0 => float vc;
0 => float vs;
0 => float vb;

for ( 0 => int k; now < timeEnd; k++ )
{
    // Play samples
    if ( k % 2 == 0 )
    {
        0 => kick.pos;
        if ( ( k % 8 != 0 ) && ( k % 8 != 6 ) )
        {
            0 => kick.pos;
            1 => snare.rate;
        }
    }
    if ( ( k % 8 == 0 ) || ( k % 8 == 6 ) )
    {
        snare.samples() => snare.pos;
        -1 => snare.rate;
    }
    0 => hihat.pos;
    
    // Play chip tune line
    k % chip.cap() => kc;
    if ( chip[kc] >= 0 )
    {
        Std.mtof( notes[chip[kc]] ) => freq;
        freq * 2 => oscChip.freq;
    }
    Math.sin( t / pi ) => pc.pan;        
    VC * Math.fabs( Math.cos( t / pi ) ) => vc;    
    
    // Play bass line    
    k % bass.cap() => kb;
    if ( bass[kb] >= 0 )
    {
        VB => vb;                                            
        Std.mtof( notes[bass[kb]] ) => freq;
        freq / 2 => oscBass.freq;
    }
    VB * Math.fabs( Math.cos( t / 0.5 * pi ) ) => oscBass.gain;                                    
    
    // Play song line        
    Math.random2( -2, notes.cap() - 1 ) => ks;
    if ( ( ks >= 0 ) && ( now >= timeStart + 4::second ) )
    {
        VS => vs;                                                            
        Std.mtof( notes[ks] ) => freq;
        freq => oscSong.freq;
    }
    else
    {
        0 => vs;                                                            
    }
    if ( now < timeStart + 2::second )
    {
        vc * ( now - timeStart ) / 2::second => vc;
    }
    if ( now > timeEnd - 5::second )
    {
        vs * ( timeEnd - now ) / 5::second => vs;
        vc * ( timeEnd - now ) / 5::second => vc;
        VB * ( timeEnd - now ) / 5::second => oscBass.gain;                                            
        ( timeEnd - now ) / 5::second => master.gain;                                            
    }
    
    vc => oscChip.gain;                                                            
    vs => oscSong.gain;                                                        
    
    // Advance time
    0.25::second => now;
    t + 11025 => t;
}
<<< "--END--" >>>;
