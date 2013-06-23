public class Drawer {
  // Constructor
  public Drawer(Player p) {
    player = p;
    coin_image = loadImage("images/coin.png");
  }

  // drawit
  public void drawit(int a_width, int c_width, int a_height, int c_height) {
    // Setting up background and colors
    background(0);
    size(640, 480);
    stroke(255);

    // Draw all the cells
    for (int i = c_width; i < a_width; i += c_width) {
      line(i, c_height, i, a_height - c_height);
    }
    for (int i = c_height; i < a_height; i += c_height) {
      line(c_width, i, a_width - c_width, i);
    }

    // Draw coins in cells
    boolean[][] alive = player.getAlive();
    for (int i = 0; i < alive.length; i++)
      for (int j = 0; j < alive[i].length; j++)
        if (alive[i][j]) {
          imageMode(CORNER);
          image(coin_image, i * c_width, j * c_height, c_width, c_height);
        }
    
    // Draw the buttons
    player.get_play_button().drawit(a_width, c_width, a_height, c_height);
    player.get_undo_button().drawit(a_width, c_width, a_height, c_height);
    player.get_reset_button().drawit(a_width, c_width, a_height, c_height);

    // Draw the timer
    player.getTimer().drawit(a_width, c_width, a_height, c_height);
    
    // Draw the scorer
    player.getScorer().drawit(a_width, c_width, a_height, c_height);
  }

  //private
  private Player player;
  private PImage coin_image, button_image;
}

