// Nice and cool byte array that can grow
// left and right from zero
class Memory {
  
  // Max size = 2 * MAX_PART_SIZE
  static final int MAX_PART_SIZE = 4096;
  static final int INITIAL_PART_SIZE = 1024;
  static final float ALLOC_RATIO = 2f; // >1
  
  int ptr;
  byte[] l, r;
  
  Memory() {
    l = new byte[INITIAL_PART_SIZE];
    r = new byte[INITIAL_PART_SIZE];
  }
  
  void reset() {
    java.util.Arrays.fill(l, (byte)0);
    java.util.Arrays.fill(r, (byte)0);
    ptr = 0;
  }
  
  byte get() {
    if (ptr >= 0)
      return r[ptr];
    else
      return l[-ptr-1];
  }
  
  void set(byte v) {
    if (ptr >= 0)
      r[ptr] = v;
    else
      l[-ptr-1] = v;
  }
  
  void mvLeft() {
    ptr--;
    // Check if resize is needed
    if (-ptr-1 >= l.length) {
      byte[] newL = resize(l);
      if (newL == null) {
        // OOB memory access
        ptr = 0;
        return;
      }
      l = newL;
    }
  }
  
  void mvRight() {
    ptr++;
    // Check if resize is needed
    if (ptr >= r.length) {
      byte[] newR = resize(r);
      if (newR == null) {
        // OOB memory access
        ptr = 0;
        return;
      }
      r = newR;
    }
  }
  
  byte[] resize(byte[] a) {
    int newSize = (int)(a.length * ALLOC_RATIO);
    if (newSize > MAX_PART_SIZE)
      return null;
    return java.util.Arrays.copyOf(a, newSize);
  }
  
}