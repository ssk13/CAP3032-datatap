import themidibus.*; //Import the library

int WIDTH = 800, HEIGHT = 600; //these vars represent the size of the window
MidiBus myBus; // The MidiBus
Reaction reactions[] = new Reaction[38];
int clicks = 0;
int colors[] = {#FFFFFF, //white
                #000000, //black
                #37B400, //green
                #E2F2F8, //light green
                #A4D49D, //pale green
                #8C7853, //brass
                #00AEEF, //bright blue
                #5573B7, //ocean blue
                #6CCFF7, //light blue
                #70DB93, //navy
                #F16522, //orange
                #DBDB70, //light yellow
                #FFF100, //bright yellow
                #FFFF00, //yellow
                #FBAF00, //golden
                #FDC68C, //dark yellow
                #A763A9, //purple
                #652C91, //purple blue
                #BC8CBF, //light purple
                #2F3192, //blue purple
                #FF0000, //red
                #F16D7E, //earth red
                #ED008C, //dark red
                #F49BC1, //pink
                #ED00FF, //rose 
                #8E236B, //brown red
                #5C3317,
                #FFFFFF, //white
                #000000, //black
                #37B400, //green
                #E2F2F8, //light green
                #A4D49D, //pale green
                #8C7853, //brass
                #00AEEF, //bright blue
                #5573B7, //ocean blue
                #6CCFF7, //light blue
                #70DB93,
                #652C91};


void setup () {
   size(WIDTH, HEIGHT); //set the window height   
   myBus = new MidiBus(this, -1, "Microsoft MIDI Mapper"); // Create a new MidiBus with no input device and the default Microsoft MIDI Mapper as the output device.
   setReactions();
}

void setReactions() {
  reactions[0] = new Reaction(36, 65, 200, colors[0]);
  reactions[1] = new Reaction(40, 82, 200, colors[1]);
  reactions[2] = new Reaction(41, 87, 200, colors[2]);
  reactions[3] = new Reaction(43, 97, 200, colors[3]);
  reactions[4] = new Reaction(46, 116, 200, colors[4]);
  reactions[5] = new Reaction(48, 130, 200, colors[5]);
  reactions[6] = new Reaction(52, 164, 200, colors[6]);
  reactions[7] = new Reaction(55, 195, 200, colors[7]);
  reactions[8] = new Reaction(58, 133, 200, colors[8]);
  reactions[9] = new Reaction(60, 261, 200, colors[9]);
  reactions[10] = new Reaction(36, 65, 200, colors[10]);
  reactions[11] = new Reaction(40, 82, 200, colors[11]);
  reactions[12] = new Reaction(41, 87, 200, colors[12]);
  reactions[13] = new Reaction(43, 97, 200, colors[13]);
  reactions[14] = new Reaction(46, 116, 200, colors[14]);
  reactions[15] = new Reaction(48, 130, 200, colors[15]);
  reactions[16] = new Reaction(52, 164, 200, colors[16]);
  reactions[17] = new Reaction(55, 195, 200, colors[17]);
  reactions[18] = new Reaction(58, 133, 200, colors[18]);
  reactions[19] = new Reaction(60, 261, 200, colors[19]);
  reactions[20] = new Reaction(36, 65, 200, colors[20]);
  reactions[21] = new Reaction(40, 82, 200, colors[21]);
  reactions[22] = new Reaction(41, 87, 200, colors[22]);
  reactions[23] = new Reaction(43, 97, 200, colors[23]);
  reactions[24] = new Reaction(46, 116, 200, colors[24]);
  reactions[25] = new Reaction(48, 130, 200, colors[25]);
  reactions[26] = new Reaction(52, 164, 200, colors[26]);
  reactions[27] = new Reaction(55, 195, 200, colors[27]);
  reactions[28] = new Reaction(58, 133, 200, colors[28]);
  reactions[29] = new Reaction(60, 261, 200, colors[29]);
  reactions[30] = new Reaction(36, 65, 200, colors[30]);
  reactions[31] = new Reaction(40, 82, 200, colors[31]);
  reactions[32] = new Reaction(41, 87, 200, colors[32]);
  reactions[33] = new Reaction(43, 97, 200, colors[33]);
  reactions[34] = new Reaction(46, 116, 200, colors[34]);
  reactions[35] = new Reaction(48, 130, 200, colors[35]);
  reactions[36] = new Reaction(52, 164, 200, colors[36]);
  reactions[37] = new Reaction(55, 195, 200, colors[37]);
}

void draw() {
  if (clicks < 5) {
    fill(255);
    textSize(32);
    text("Use your number and letter keys to activate", 55, 50);
  }
}

void keyPressed() {
  if (clicks < 5) {
     ++clicks; 
  }
  Reaction active = new Reaction(0,0,0,0);
  if ((int) key > 46 && (int) key < 57) {
    active = reactions[(int) key - 48];
  } else if ((int) key > 96 && (int) key < 122) {
    active = reactions[(int) key - 85];
  }
  active.perform(myBus);
}

class Reaction {
  int velocity;
  int pitch;
  int delay;
  int colorVal;
  int channel = 0;

  Reaction(int pitch, int velocity, int delay, int colorVal) {
    this.velocity = velocity;
    this.pitch = pitch;
    this.delay = delay;
    this.colorVal = colorVal;
  }

  void perform(MidiBus bus) {
    background(colorVal);
    bus.sendNoteOn(channel, pitch, velocity);
    delay(delay);
    bus.sendNoteOff(channel, pitch, velocity);

    int number = 0;
    int value = 90;

    bus.sendControllerChange(channel, number, value);
  }
}
