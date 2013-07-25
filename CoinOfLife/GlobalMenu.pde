public class GlobalMenu {

  public GlobalMenu(int a_width, int c_width, int a_height, int c_height) {
    int button_width = width - a_width - c_width;
    int button_height = c_width * 2;
    continue_button = new CoinButton((int)((width - button_width) / 2), (int)((height) / 2) + 200, button_width, button_height, "Next Level");
  }
  
  public void display() {
    background(0);
    stroke(255);
    continue_button.drawit();
  }
  
  // Getters
  public int getCoins() {
    return coins;
  }
  public int getGems() {
    return gems;
  }
  public int getDiamonds() {
    return diamonds;
  }
  public int getRocks() {
    return rocks;
  }
  public CoinButton getContinueButton() {
    return continue_button;
  }
  
  //Setters
  public void setCoins(int i) {
    coins = coins + i;
  }
  public void setGems(int i) {
    gems = gems + i;
  }
  public void setDiamonds(int i) {
    diamonds = diamonds+ i;
  }
  public void setRocks(int i) {
    rocks = rocks + i;
  }
  
  // Coins, Gems, Diamond
  private int coins, gems, diamonds, rocks;
  
  // Continue Button
  private CoinButton continue_button;
}
