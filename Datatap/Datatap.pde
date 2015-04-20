//import library for playing .wav files
import ddf.minim.*; 
AudioPlayer song;
Minim minim;

int WIDTH = 800, HEIGHT = 600; 
Reaction reactions[] = new Reaction[38]; 
boolean initialized = false, changed = false, keys[] = new boolean[38];
int fading = 0, lastKey, setSize[] = {38, 15, 8, 8, 12};
String sets[] = { "drums", "piano", "acoustic", "bass", "electric" }, set = sets[0];
char keyChars[] = {'1', '2', '3', '4', '5', '6', '7', '8', '9', '0', 'q', 'w', 'e', 
                   'r', 't', 'y', 'u', 'i', 'o', 'p', 'a', 's', 'd', 'f', 'g', 'h', 
                   'j', 'k', 'l', 'z', 'x', 'c', 'v', 'b', 'n', 'm'};

/*
  Initialize the application and apply a setting for first use
*/
void setup () {
   size(WIDTH, HEIGHT);  
   setReactions();
   minim = new Minim(this);
}

/*
  Applies a setting to the application, selecting an instrument other than the current one and initializing the reactions array with 
  its sounds
*/
void setReactions() {
  fading = 0;
  changed = true;
  int setNumber = (int) random(sets.length);
  while (sets[setNumber] == set) {
     setNumber = (int) random(sets.length); 
  }
  set = sets[setNumber];
  for (int i = 0; i < 38; ++i) {
     reactions[i] = new Reaction("sounds/" + (String) set + "/Shuffle" + (((int) random(setSize[setNumber])) + 1)+ ".wav");  
  }
}

/*
  Draws the app's interface
*/
void draw() {
  //if we're transitioning [100 frames], change the background color appropriately
  if (fading < 100) {
      fill(0, 0, 0, fading);
      rect(0, 0, WIDTH, HEIGHT);
      ++fading;
      //if we haven't yet shown the instructions
      if (initialized == false) {
         fill(255);
         textSize(32);
         text("Use your number and letter keys to activate", 55, 50);
         text("Use the space bar to shuffle", 175, 90);
      } else if (fading < 95) {
         fill(255);
         textSize(32);
         text("Shuffling", 350, 50);
      }
  } 
  //if we've just changed the instrument and not yet set the new background, set it appropriately
  else if (changed) {
    PImage img = loadImage("backgrounds/" + set + ".png");
    image(img, 0, 0, WIDTH, HEIGHT);
    changed = false;
  }
  //if we're immersed in the application, draw the keyboard appropriately
  else {
    stroke(255, 255, 255, 120);
    for (int i = 0; i < 10; ++i) {
      noFill();
       if (keys[(int) keyChars[i] - 48]) {
          stroke(255, 0, 0);
          ellipse(120 + 60*i, 350, 40, 40);
          noStroke();
          fill(255, 255, 255, 255);
       } else {
         stroke(255);
         ellipse(120 + 60*i, 350, 40, 40);
         noStroke();
         fill(255, 255, 255, 120);
       }
       textSize(28);
       text(keyChars[i], 110 + 60*i, 360);
       stroke(255,255,255,120);
       noFill();
    } 
    for (int i = 0; i < 10; ++i) {
       if (keys[(int) keyChars[i + 10] - 85]) {
          stroke(255, 0, 0);
          ellipse(150 + 60*i, 410, 40, 40);
          noStroke();
          fill(255, 255, 255, 255);
          
       } else {
         stroke(255);
          ellipse(150 + 60*i, 410, 40, 40);
          noStroke();
          fill(255, 255, 255, 120);
       }
       textSize(28);
       text(keyChars[i + 10], 140 + 60*i, 420);
       stroke(255,255,255,120);
       noFill();
    } 
    for (int i = 0; i < 9; ++i) {
       if (keys[(int) keyChars[i + 20] - 85]) {
          stroke(255, 0, 0);
          ellipse(180 + 60*i, 470, 40, 40);
          noStroke();
          fill(255, 255, 255, 255);
       } else {
         stroke(255);
          ellipse(180 + 60*i, 470, 40, 40);
          noStroke();
          fill(255, 255, 255, 120);
       }
       textSize(28);
       text(keyChars[i + 20], 170 + 60*i, 480);
       stroke(255,255,255,120);
       noFill();
    } 
    for (int i = 0; i < 7; ++i) {
       if (keys[(int) keyChars[i + 29] - 85]) {
          stroke(255, 0, 0);
          ellipse(210 + 60*i, 530, 40, 40);
          noStroke();
          fill(255, 255, 255, 255);
       } else {
         stroke(255);
          ellipse(210 + 60*i, 530, 40, 40);
          noStroke();
          fill(255, 255, 255, 120);
       }
       textSize(28);
       text(keyChars[i + 29], 200 + 60*i, 540);
       stroke(255,255,255,120);
       noFill();
    } 
  }
}

/*
  Event listener that handles all key presses
*/
void keyPressed() {
  if (initialized == false) {
     initialized = true; 
  }
  //stop the fading effect once a key has been pressed
  if (fading < 100) {
     fading = 100; 
  }
  Reaction active;
  //handles the shuffle function
  if ((int) key == 32) {
      setReactions();
  }
  //handles the number keys
  else if ((int) key > 46 && (int) key < 58) {
    active = reactions[(int) key - 48];
    keys[lastKey] = false;
    keys[(int) key - 48] = true;
    lastKey = (int) key - 48;
    active.keyVal = key;
    active.perform();
  } 
  //handles the letter keys
  else if ((int) key > 96 && (int) key < 123) {
    active = reactions[(int) key - 85];
    keys[lastKey] = false;
    keys[(int) key - 85] = true;
    lastKey = (int) key - 85;
    active.keyVal = key;
    active.perform();
  }
  else {
     return;
  }
}

/*
  Reaction object associated with each key, with variables determined by the
  application's settings
*/
class Reaction {
  int keyVal;
  String file;

//constructor
  Reaction(String file) {
    this.file = file;
  }

//performs the action intended by the key press
  void perform() {
    noFill();
    song = minim.loadFile(file);
    song.play();

    int number = 0;
    int value = 90;
  }
}

//closes the applciation
void stop() {
  song.close();
  minim.stop();
  super.stop();
}

