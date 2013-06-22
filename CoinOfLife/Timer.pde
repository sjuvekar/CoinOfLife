
class Timer {
  // Constructor
  public Timer(int x, int y, int max_value) {
    this.x = x;
    this.y = y;
    this.max_value = max_value;
    this.curr_value = 0;
  }

  //drawit
  public void drawit(int a_width, int c_width, int a_height, int c_height) {
    textSize(20);
    fill(255);
    text("Time", x, y);
    fill(0, 255, 0);
    rect(x, y + c_height, (int)( (width - a_width - c_width) * (max_value - curr_value) / max_value), c_height);
  }
  
  // advance timer
  public void advanceit() {
    curr_value++;
  }
  
  // check if it is timed out
  public boolean isTimeout() {
    return (curr_value >= max_value);
  }
  
  //private
  private int x, y;
  private int max_value, curr_value;
}

