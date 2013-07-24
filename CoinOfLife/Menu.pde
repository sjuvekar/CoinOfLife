public class Menu {
  
  public Menu(int a_width, int c_width, int a_height, int c_height) {
    int button_width = width - a_width - c_width;
    int button_height = c_width * 2;
    start_button = new CoinButton(width / 2, height / 2, button_width, button_height, "Start");
  }
  
  // getter 
  public CoinButton getStartButton() {
    return start_button;
  }
  
  public void display() {
     start_button.drawit();
  }
  
  // Button
  private CoinButton start_button;
}
