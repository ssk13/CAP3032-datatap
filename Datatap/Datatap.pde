import themidibus.*; //Import the library

int WIDTH = 800, HEIGHT = 600; //these vars represent the size of the window
MidiBus myBus; // The MidiBus
Reaction reactions[] = new Reaction[38];


void setup () {
   size(WIDTH, HEIGHT); //set the window height   
   myBus = new MidiBus(this, -1, "Microsoft MIDI Mapper"); // Create a new MidiBus with no input device and the default Microsoft MIDI Mapper as the output device.
   setReactions();
}

void setReactions() {
  reactions[0] = new Reaction(36, 65, 200);
  reactions[1] = new Reaction(40, 82, 200);
  reactions[2] = new Reaction(41, 87, 200);
  reactions[3] = new Reaction(43, 97, 200);
  reactions[4] = new Reaction(46, 116, 200);
  reactions[5] = new Reaction(48, 130, 200);
  reactions[6] = new Reaction(52, 164, 200);
  reactions[7] = new Reaction(55, 195, 200);
  reactions[8] = new Reaction(58, 133, 200);
  reactions[9] = new Reaction(60, 261, 200);
  reactions[10] = new Reaction(36, 65, 200);
  reactions[11] = new Reaction(40, 82, 200);
  reactions[12] = new Reaction(41, 87, 200);
  reactions[13] = new Reaction(43, 97, 200);
  reactions[14] = new Reaction(46, 116, 200);
  reactions[15] = new Reaction(48, 130, 200);
  reactions[16] = new Reaction(52, 164, 200);
  reactions[17] = new Reaction(55, 195, 200);
  reactions[18] = new Reaction(58, 133, 200);
  reactions[19] = new Reaction(60, 261, 200);
  reactions[20] = new Reaction(36, 65, 200);
  reactions[21] = new Reaction(40, 82, 200);
  reactions[22] = new Reaction(41, 87, 200);
  reactions[23] = new Reaction(43, 97, 200);
  reactions[24] = new Reaction(46, 116, 200);
  reactions[25] = new Reaction(48, 130, 200);
  reactions[26] = new Reaction(52, 164, 200);
  reactions[27] = new Reaction(55, 195, 200);
  reactions[28] = new Reaction(58, 133, 200);
  reactions[29] = new Reaction(60, 261, 200);
  reactions[30] = new Reaction(36, 65, 200);
  reactions[31] = new Reaction(40, 82, 200);
  reactions[32] = new Reaction(41, 87, 200);
  reactions[33] = new Reaction(43, 97, 200);
  reactions[34] = new Reaction(46, 116, 200);
  reactions[35] = new Reaction(48, 130, 200);
  reactions[36] = new Reaction(52, 164, 200);
  reactions[37] = new Reaction(55, 195, 200);
}

void draw() {
}

void keyPressed() {
  Reaction active = new Reaction(0,0,0);
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
  int channel = 0;

  Reaction(int pitch, int velocity, int delay) {
    this.velocity = velocity;
    this.pitch = pitch;
    this.delay = delay;
  }

  void perform(MidiBus bus) {
    bus.sendNoteOn(channel, pitch, velocity);
    delay(delay);
    bus.sendNoteOff(channel, pitch, velocity);

    int number = 0;
    int value = 90;

    bus.sendControllerChange(channel, number, value);
  }
}
