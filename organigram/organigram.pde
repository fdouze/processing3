import processing.sound.*;
TriOsc triOsc;
Env env; 

// Times and levels for the ASR envelope
float attackTime = 0.001;
float sustainTime = 0.2;
float sustainLevel = 0.5;
float releaseTime = 0.002;
int m;
float amp;

// Variable use for framerate
int fr=12;

void setup() {
  size(800, 400);
  background(255);
  
  // Create triangle wave and the envelop
  triOsc = new TriOsc(this);
  env  = new Env(this);
  
  //framerate use the variable above
  frameRate(fr);
}
void draw(){
  //each time draw is use (fr times a second) we add a layer of white with an opacity of 225*2/fr ca makes disappear a bar in 2 seconds
  noStroke();
  fill(255,255,255,255*2/fr);
  rect(0,0,width,height);
  
  //random function to define the note tone and play it
  m = int(random(40,120));
  amp = random(0.2, 1);
  triOsc.play(midiToFreq(m), amp);
  env.play(triOsc, attackTime, sustainTime, sustainLevel, releaseTime);
  
  //draw the bar corresponding to the note
  fill(240,20,157);
  rect(map(m,40,120,0,width),map(amp,0.2,1,0,height),width/80,height);
  }

// This function calculates the respective frequency of a MIDI note
float midiToFreq(int note){
    return (pow(2, ((note-69)/12.0)))*440; 
}