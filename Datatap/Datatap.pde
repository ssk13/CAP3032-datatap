import themidibus.*; //Import the library

int WIDTH = 800, HEIGHT = 600; //these vars represent the size of the window
MidiBus myBus; // The MidiBus
Reaction reactions[] = new Reaction[10];
boolean channels[] = new boolean[16];


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
}

void draw() {
}

int getFreeChannel() {
  for (int i = 0; i < 16; ++i) {
    if (channels[i]) {
      return i;
    }
  }
  return 0;
}

void keyPressed() {
  Reaction active = new Reaction(0,0,0);
  switch(key) {
    case '0':
    case '1':
    case '2':
    case '3':
    case '4':
    case '5':
    case '6':
    case '7':
    case '8':
    case '9':
      active = reactions[(int) key - 48];
      break;
    default:
      break;
  }
  active.perform(myBus, getFreeChannel());
}

class Reaction {
  int velocity;
  int pitch;
  int delay;
  int channel = 0;

  Reaction(int velocity, int pitch, int delay) {
    this.velocity = velocity;
    this.pitch = pitch;
    this.delay = delay;
  }

  void perform(MidiBus bus, int channel) {
    channels[channel] = true;
    bus.sendNoteOn(channel, pitch, velocity);
    delay(delay);
    bus.sendNoteOff(channel, pitch, velocity);

    int number = 0;
    int value = 90;

    bus.sendControllerChange(channel, number, value);
    channels[channel] = false;
  }
}
