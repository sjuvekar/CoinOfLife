public class Menu {
  
  public Menu(int a_width, int c_width, int a_height, int c_height) {
    int button_width = width - a_width - c_width;
    int button_height = c_width;
    start_button = new CoinButton((int)((width - button_width) / 2), (int)((height) / 2) + 200, button_width, button_height, "Start");
    tut_button = new CoinButton((int)((width - button_width) / 2) - button_width, (int)((height) / 2) + 205, button_width - 20, button_height - 10, "Tutorial");
    store_button = new CoinButton((int)((width - button_width) / 2) + button_width + 10, (int)((height) / 2) + 205, button_width - 20, button_height - 10, "Store");
    sound_button = new Toggle("", width - 4 * c_width, height - 4 * c_height, 2 * c_width, 2 * c_height);
  }
  
  // getter 
  public CoinButton getStartButton() {
    return start_button;
  }
  
  public Toggle getSoundButton() {
    return sound_button;
  }
  
  public void display() {
    background(0);
    stroke(255);
    imageMode(CENTER);
    image(G_LOGO_IMAGE, width/2, height/2 - 200, 250, 250);
    pushStyle();
    textSize(60);
    text("Coin Of Life", width/2 - 150, height/2);
    textSize(30);
    fill(183, 154, 0);
    text("The most addictive coin game ever!", width/2 - 225, height/2 + 50);
    fill(255);
    textSize(20);
    text("Place coins on board, watch them evolve, earn gems, diamonds and rocks!", width/2 - 350, height/2 + 100);
    popStyle();
    start_button.drawit();
    tut_button.drawit();
    store_button.drawit();
    if (G_SOUND_STATE)
      sound_button.setActiveImage(G_SOUNDON_IMAGE);
    else
      sound_button.setActiveImage(G_SOUNDOFF_IMAGE);
    sound_button.display();
  }
  
  // Button
  private CoinButton start_button, tut_button, store_button;
  private Toggle sound_button;
}
