class Input {
  
  byte[] input;
  int ptr;
  
  Input(String input) {
    // Get UTF-8 bytes
    this.input = input.getBytes(java.nio.charset.StandardCharsets.UTF_8);
  }
  
  byte next() {
    if (ptr < input.length)
      return input[ptr++];
    else
      return 0;
  }
  
}