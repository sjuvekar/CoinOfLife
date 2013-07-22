public class Drawer {
  // Constructor
  public Drawer(Player p) {
    player = p;
  }

  // drawit
  public void drawit(int a_width, int c_width, int a_height, int c_height) {
    // Setting up background and colors
    background(0);
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
    boolean[][] ever_alive = player.getEverAlive();
    int[][] gem_positions = player.getGemPositions();
    
    for (int i = 0; i < alive.length; i++) {
      for (int j = 0; j < alive[i].length; j++) {
        if (ever_alive[i][j]) {
          fill(75, 75, 75);
          rect(i * c_width, j * c_height, c_width, c_height);
          gem_positions[i][j] = 0;
        }
        if (alive[i][j]) {
          imageMode(CORNER);
          image(G_COIN_IMAGE, i * c_width, j * c_height, c_width, c_height);
        }
        if (gem_positions[i][j] == 1) {
          imageMode(CORNER);
          image(G_GEM_IMAGE, i * c_width, j * c_height, c_width, c_height);
        }
      }
    }
    
    // Draw the buttons
    player.get_play_button().drawit();
    player.get_undo_button().drawit();
    player.get_reset_button().drawit();

    // Draw the timer
    player.getTimer().drawit(a_width, c_width, a_height, c_height);
    
    // Draw the scorer
    player.getScorer().drawit(a_width, c_width, a_height, c_height);
  }

  //private
  private Player player;
}

