ControlWindow cw;

Memory mem = new Memory();
CodeParser parser;
StringBuilder output;
Mode m = Mode.Throttle;

// TODO implement with threads
enum Mode {
  Slow,     // One operation per frame
  Throttle, // One IO operation per frame
  Fast,     // Use thread
}

void setup() {
  cw = new ControlWindow();
  frameRate(60);
}

void draw() {
  if (parser != null) {
    if (parser.done) {
      background(0, 0xFF, 0);
    } else {
      background(0x00);
      switch (m) {
        case Throttle: {
          do {
            parser.next();
          } while (!parser.done && !parser.didIO);
          break;
        }
        case Slow: {
          parser.next();
          break;
        }
      }
      
    }
  } else {
    background(0xFF);
  }
}