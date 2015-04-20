import ddf.minim.*; 
AudioPlayer song;
Minim minim;

int WIDTH = 800, HEIGHT = 600; //these vars represent the size of the window
Reaction reactions[] = new Reaction[38];
boolean initialized = false, changed = false, keys[] = new boolean[38];
int fading = 0, lastKey, setSize[] = {38, 17, 6, 17};
String sets[] = { "drums", "jazz", "indie", "latin" }, set = sets[0];
char keyChars[] = {'1', '2', '3', '4', '5', '6', '7', '8', '9', '0', 'q', 'w', 'e', 
                   'r', 't', 'y', 'u', 'i', 'o', 'p', 'a', 's', 'd', 'f', 'g', 'h', 
                   'j', 'k', 'l', 'z', 'x', 'c', 'v', 'b', 'n', 'm'};

void setup () {
   size(WIDTH, HEIGHT); //set the window height   
   setReactions();
   minim = new Minim(this);
}

void setReactions() {
  fading = 0;
  changed = true;
  int setNumber = (int) random(sets.length);
  set = sets[setNumber];
  for (int i = 0; i < 38; ++i) {
     reactions[i] = new Reaction("sounds/" + (String) set + "/Shuffle" + (((int) random(setSize[setNumber])) + 1)+ ".wav");  
  }
}

void draw() {
  if (fading < 200) {
      fill(0, 0, 0, fading);
      rect(0, 0, WIDTH, HEIGHT);
      ++fading;
      if (initialized == false) {
         fill(255);
         textSize(32);
         text("Use your number and letter keys to activate", 55, 50);
         text("Use the space bar to shuffle", 175, 90);
      } else if (fading < 195) {
         fill(255);
         textSize(32);
         text("Shuffling", 350, 50);
      }
  } 
  else if (changed) {
    PImage img = loadImage("backgrounds/" + set + ".png");
    image(img, 0, 0, WIDTH, HEIGHT);
    changed = false;
  }
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
  else if ((int) key > 46 && (int) key < 58) {
    active = reactions[(int) key - 48];
    keys[lastKey] = false;
    keys[(int) key - 48] = true;
    lastKey = (int) key - 48;
    active.keyVal = key;
    active.perform();
  } else if ((int) key > 96 && (int) key < 123) {
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

class Reaction {
  int keyVal;
  String file;

  Reaction(String file) {
    this.file = file;
  }

  void perform() {
    noFill();
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

