public class TutDrawer {
  
  public TutDrawer(Player p) {
    player = p;
  }
  
  // drawit
  public void drawit(int a_width, int c_width, int a_height, int c_height) {
    // Setting up background and colors
    background(0);
    stroke(255);

    // Draw all the cells
    for (int i = c_width; i < a_width - c_width; i += c_width) {
      line(i, c_height, i, a_height - c_height);
    }
    for (int i = c_height; i < a_height; i += c_height) {
      line(c_width, i, a_width - (int)(3 * c_width / 2), i);
    }
    
    // Red Squares
    pushStyle();
    fill(104, 0, 0);
    for (int i = 0; i < TUT_POS_X.length; i++) 
      rect(TUT_POS_X[i] * c_width, TUT_POS_Y[i] * c_height, c_width, c_height);
    popStyle(); 
    
    // Draw coins in cells
    boolean[][] alive = player.getAlive();
    boolean[][] ever_alive = player.getEverAlive();
    for (int i = 0; i < alive.length; i++) {
      for (int j = 0; j < alive[i].length; j++) {
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
      }
    }
    
    // Draw the buttons
    player.get_play_button().drawit();

    // Draw the timer
    player.getTimer().drawit(a_width, c_width, a_height, c_height);
   
    // Draw instructions
    pushStyle();
    fill(255, 255, 255);
    
    if (player.getState() == Player.TUT_SIMULATING || player.getState() == Player.TUT_READY) {
      textSize(40);
      text("Hit Play!", a_width, height / 2);
    }
    else if (player.getState() == Player.TUT_TIMEOUT) {
      textSize(20);
      text("Try placing", a_width, height / 2);
      text("different coins", a_width, height / 2 + 30);
      text("on board and", a_width, height / 2 + 60);
      text("collide with", a_width, height / 2 + 90);
      text("gems/diamonds", a_width, height / 2 + 120);
    }
    else {
      textSize(20);
      text("Tap the Red Squares", a_width - c_width, height / 2);
    }
    popStyle();
  }
  
  private Player player;
}
