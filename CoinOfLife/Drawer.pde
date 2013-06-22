class Drawer {
  private Player player;
  private PImage coin_image, button_image;
  private PImage[] digit_images;
  private Button play_button, undo_button, reset_button;
  
  public Drawer(Player p) {
    int a_width = arena_width();
    int c_width = cell_width();
    int a_height = arena_height();
    int c_height = cell_height();
    
    // Create player
    player = p;
    coin_image = loadImage("images/coin.png");
    digit_images = new PImage[10];
    for (int i = 0; i < 10; i++)
      digit_images[i] = loadImage("images/" + i + ".png");
    
    // Create buttons  
    int button_x = a_width;
    int play_y = c_height;
    int undo_y = c_height * 4;
    int reset_y = (int)(c_height * 7.5);
    int button_width = width - a_width - c_width;
    int button_height = c_width * 2;
    play_button = new Button(button_x, play_y, button_width, button_height, "Play");
    undo_button = new Button(button_x, undo_y, button_width, button_height, "Undo");
    reset_button = new Button(button_x, reset_y, button_width, button_height, "Reset");
    
  }


  public void drawit(int a_width, int c_width, int a_height, int c_height) {
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
    play_button.drawit(a_width, c_width, a_height, c_height);
    undo_button.drawit(a_width, c_width, a_height, c_height);
    reset_button.drawit(a_width, c_width, a_height, c_height);

    // Draw the timer
    player.getTimer().drawit(a_width, c_width, a_height, c_height);
  }
  
}

