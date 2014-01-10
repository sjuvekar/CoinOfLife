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
    int n_horizontal = (int)(a_width / c_width);
    int n_vertical = (int)(a_height / c_height);
    
    // Draw all the cells
    for (int i = 1; i < n_horizontal; i++) {
      line(i * c_width, 2 * c_height, i * c_width, n_vertical * c_height);
    }
    for (int i = 2; i <= n_vertical; i++) {
      line(c_width, i * c_height, (n_horizontal - 1) * c_width, i * c_height);
    }

    // Draw coins in cells
    boolean[][] alive = player.getAlive();
    boolean[][] ever_alive = player.getEverAlive();
    boolean[][] gem_positions = player.getGemPositions();
    boolean[][] diamond_positions = player.getDiamondPositions();
    boolean[][] rock_positions = player.getRockPositions();
    boolean[][] hit_positions = player.getHitPositions();
    
    for (int i = 0; i < alive.length; i++) {
      for (int j = 2; j < alive[i].length; j++) {
        if (ever_alive[i][j]) {
          pushStyle();
          fill(75, 75, 75);
          rect(i * c_width, j * c_height, c_width, c_height);
          popStyle();
        }
        if (alive[i][j]) {
          imageMode(CORNER);
          image(G_COIN_IMAGE, i * c_width, j * c_height, c_width, c_height);
        }
        if (gem_positions[i][j]) {
          imageMode(CORNER);
          image(G_GEM_IMAGE, i * c_width, j * c_height, (int)(c_width * 1.1), (int)(c_height * 1.1));
        }
        if (diamond_positions[i][j]) {
          imageMode(CORNER);
          image(G_DIAMOND_IMAGE, i * c_width, j * c_height, (int)(c_width * 1.1), (int)(c_height * 1.1));
        }
        if (rock_positions[i][j]) {
          imageMode(CORNER);
          image(G_ROCK_IMAGE, i * c_width, j * c_height, (int)(c_width * 1.1), (int)(c_height * 1.1));
        }
        if (hit_positions[i][j]) {
          imageMode(CENTER);
          image(G_HIT_IMAGE, (int)((i+0.5) * c_width), (int)((j+0.5) * c_height), (int)(c_width * 1.8), (int)(c_height * 1.8));
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
    player.getCoinScorer().drawit();
    player.getGemScorer().drawit();
    player.getDiamondScorer().drawit();
    player.getRockScorer().drawit();
  }

  //private
  private Player player;
}

