public class Menu {
  
  public Menu(int a_width, int c_width, int a_height, int c_height) {
    int button_width = width - a_width - c_width;
    int button_height = c_width * 2;
    start_button = new CoinButton((int)((width - button_width) / 2), (int)((height) / 2) + 200, button_width, button_height, "Start");
  }
  
  // getter 
  public CoinButton getStartButton() {
    return start_button;
  }
  
  public void display() {
    imageMode(CENTER);
    image(G_LOGO_IMAGE, width/2, height/2 - 200, 250, 250);
    start_button.drawit();
  }
  
  // Button
  private CoinButton start_button;
}
