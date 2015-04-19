import ddf.minim.*; 
AudioPlayer song;
Minim minim;

int WIDTH = 800, HEIGHT = 600; //these vars represent the size of the window
Reaction reactions[] = new Reaction[38];
boolean initialized = false;
int clicks = 0, fading = 0;
String files[] = {
  "sounds/Shuffle1.wav", "sounds/Shuffle2.wav", "sounds/Shuffle3.wav", "sounds/Shuffle4.wav", 
  "sounds/Shuffle5.wav", "sounds/Shuffle6.wav", "sounds/Shuffle1.wav", "sounds/Shuffle2.wav", "sounds/Shuffle3.wav", "sounds/Shuffle4.wav", 
  "sounds/Shuffle5.wav", "sounds/Shuffle6.wav", "sounds/Shuffle1.wav", "sounds/Shuffle2.wav", "sounds/Shuffle3.wav", "sounds/Shuffle4.wav", 
  "sounds/Shuffle5.wav", "sounds/Shuffle6.wav", "sounds/Shuffle1.wav", "sounds/Shuffle2.wav", "sounds/Shuffle3.wav", "sounds/Shuffle4.wav", 
  "sounds/Shuffle5.wav", "sounds/Shuffle6.wav", "sounds/Shuffle1.wav", "sounds/Shuffle2.wav", "sounds/Shuffle3.wav", "sounds/Shuffle4.wav", 
  "sounds/Shuffle5.wav", "sounds/Shuffle6.wav", "sounds/Shuffle1.wav", "sounds/Shuffle2.wav", "sounds/Shuffle3.wav", "sounds/Shuffle4.wav", 
  "sounds/Shuffle5.wav", "sounds/Shuffle6.wav", "sounds/Shuffle1.wav", "sounds/Shuffle2.wav", "sounds/Shuffle3.wav", "sounds/Shuffle4.wav", 
  "sounds/Shuffle5.wav", "sounds/Shuffle6.wav"
};
int colors[] = {#FFFFFF,  //white
                #0000ff,  //blue
                #37B400,  //green
                #E2F2F8,  //very light blue
                #A4D49D,  //light green
                #8C7853,  //light brown
                #00AEEF,  //med blue
                #257e43,  //med green
                #5573B7,  //sky blue
                #6CCFF7,  //light teal
                #F16522,  //orange
                #DBDB70,  //light yellow
                #FFF100,  //yellow
                #9f9f02,  //dark yellow
                #FBAF00,  //yellow-orange
                #FDC68C,  //light orange
                #A763A9,  //lilac
                #652C91,  //purple blue
                #BC8CBF,  //light purple
                #2F3192,  //blue purple
                #FF0000,  //red
                #F16D7E,  //earth red
                #ED008C,  //dark red
                #F49BC1,  //pink
                #ED00FF,  //rose 
                #8E236B,  //brown red
                #5C3317,  //brown
                #FFFFFF,  //white
                #00ff00,  //green
                #37B400,  //green
                #E2F2F8,  //light green
                #A4D49D,  //pale green
                #8C7853,  //brass
                #00AEEF,  //bright blue
                #5573B7,  //ocean blue
                #6CCFF7,  //light blue
                #70DB93,  //mint
                #652C91   //purple blue 
              };


void setup () {
   size(WIDTH, HEIGHT); //set the window height   
   setReactions();
   minim = new Minim(this);
}

void setReactions() {
  fading = 0;
  for (int i = 0; i < 38; ++i) {
     reactions[i] = new Reaction(colors[i], files[i]); 
  }
}

void draw() {
  if (fading < 256) {
      fill(0, 0, 0, fading);
      rect(0, 0, WIDTH, HEIGHT);
      ++fading;
      if (initialized == false) {
         fill(255);
         textSize(32);
         text("Use your number and letter keys to activate", 55, 50);
      }
  } 
}

void keyPressed() {
  if (initialized == false) {
     initialized = true; 
  }
  if (fading < 256) {
     fading = 256; 
  }
  Reaction active;
  if ((int) key == 32) {
      setReactions();
  }
  else if ((int) key > 46 && (int) key < 57) {
    active = reactions[(int) key - 48];
    active.keyVal = key;
    active.perform();
  } else if ((int) key > 96 && (int) key < 122) {
    active = reactions[(int) key - 85];
    active.keyVal = key;
    active.perform();
  }
  else {
     return;
  }
}

class Reaction {
  int colorVal, keyVal;
  String file;

  Reaction(int colorVal, String file) {
    this.colorVal = colorVal;
    this.file = file;
  }

  void perform() {
    background(colorVal);
    noFill();
    stroke(255);
    int x = ((int) random(WIDTH - 50)) + 25;
    int y = ((int) random(HEIGHT - 50)) + 25;
    ellipse(x, y, 50, 50);
    fill(255);
    textSize(40);
    text((char) keyVal, x - 10, y + 10);
    
    song = minim.loadFile(file);
    song.play();

    int number = 0;
    int value = 90;
  }
}

void stop() {
  song.close();
  minim.stop();
  super.stop();
}
