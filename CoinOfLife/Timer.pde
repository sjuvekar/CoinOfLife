
public class Timer {
  // Constructor
  public Timer(int x, int y, int max_value) {
    this.x = x;
    this.y = y;
    init(max_value);
  }

  public void init(int max_value) {
    this.max_value = max_value;
    this.curr_value = 0;
  }
  
  //drawit
  public void drawit(int a_width, int c_width, int a_height, int c_height) {
    fill(197,179,88);
    textFont(G_CLOCK_FONT, 30);    
    text("Time", x, y);
    
    fill(153,101,21);
    rect(x, y + (int)(c_height/2), (int)( (width - a_width - c_width) * (max_value - curr_value) / max_value), (int)(c_height/2));
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

