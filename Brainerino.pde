import java.util.Stack;

void cleanup() {
  parser = null;
  output = null;
  mem.reset();
  cw.updateOutput();
}

void runProgram(String source, String inputStr) {
  cleanup();
  output = new StringBuilder();
  parser = new CodeParser(source, inputStr);
}

class CodeParser {
  
  char[] code;
  int ptr;
  boolean done, didIO;
  Input input;
  // TODO Custom stack implemenatation
  // to cache [ locations
  Stack<Integer> stack;
  
  CodeParser(String str, String in) {
    this.code = str.toCharArray();
    this.ptr = 0;
    this.done = false;
    this.input = new Input(in);
    this.stack = new Stack<Integer>();
  }
  
  void next() {
    boolean isComment = true;
    while (isComment) {
      if (ptr >= code.length) {
        done = true;
        return;
      }
      
      isComment = false;
      didIO = false;
      char token = code[ptr];
      switch (token) {
        case '+': mem.set((byte)(mem.get()+1)); break;
        case '-': mem.set((byte)(mem.get()-1)); break;
        case '>': mem.mvRight(); break;
        case '<': mem.mvLeft();  break;
        case '[': beginLoop();   break;
        case ']': endLoop();     break;
        case '.': write();       break;
        case ',': read();        break;
        default:  isComment = true; break;
      }
      ptr++;
    }
  }
  
  void beginLoop() {
    if (mem.get() == 0) {
      // Skip to next ']'
      char token;
      do {
        token = code[ptr++];
        if (ptr >= code.length)
          return;
      } while (token != ']');
    } else {
      stack.push(ptr);
    }
  }
  
  void endLoop() {
    if (mem.get() != 0) {
      // Skip to last '['
      if (stack.empty())
        return;
      
      int pos = stack.pop();
      ptr = pos-1;
    }
  }
  
  void write() {
    output.append((char) mem.get());
    cw.updateOutput();
    didIO = true;
  }
  
  void read() {
    mem.set(input.next());
    didIO = true;
  }
  
}