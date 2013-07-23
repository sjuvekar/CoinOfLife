/* @pjs preload="coin.png, button.png, active_button.png, gem.png, diamond.png, rock.png, 0.png, 1.png, 2.png, 3.png, 4.png, 5.png, 6.png, 7.png, 8.png, 9.png"; crisp="true"; */                 
/* @pjs font="data/Clock.ttf, data/Button.ttf"; crisp=true; */ 
Player player;
Drawer drawer;

PImage G_COIN_IMAGE, G_BUTTON_IMAGE, G_ACTIVE_BUTTON_IMAGE, G_GEM_IMAGE, G_DIAMOND_IMAGE, G_ROCK_IMAGE, G_HIT_IMAGE;
PImage[] G_DIGIT_IMAGES;

PFont G_CLOCK_FONT, G_BUTTON_FONT;

void setup() {
  // Setting up background and colors
  background(0);
  size(1240, 768);
  stroke(255);

  // Preload images
  G_COIN_IMAGE = loadImage("coin.png");
  G_BUTTON_IMAGE = loadImage("button.png");
  G_ACTIVE_BUTTON_IMAGE = loadImage("active_button.png");
  
  G_DIGIT_IMAGES = new PImage[10];
  for (int i = 0; i < 10; i++)
    G_DIGIT_IMAGES[i] = loadImage(i + ".png");
  G_GEM_IMAGE = loadImage("gem.png");
  G_DIAMOND_IMAGE = loadImage("diamond.png");
  G_ROCK_IMAGE = loadImage("rock.png");
  G_HIT_IMAGE = loadImage("hit.png");
  
  // Preload font
  G_CLOCK_FONT = createFont("Clock.ttf", 48);
  G_BUTTON_FONT = createFont("Button.ttf", 24);
  
  int a_width = arena_width();
  int c_width = cell_width();
  int a_height = arena_height();
  int c_height = cell_height();
  int max_grid_x = max_grid_X();
  int max_grid_y = max_grid_Y();
  player = new Player(a_width, c_width, a_height, c_height, max_grid_x, max_grid_y);
  drawer = new Drawer(player);
}

void draw() {
  if (player.getState() == Player.SIMULATING) 
    player.simulate();
  if (player.getState() == Player.TIMEOUT) {
    player.advanceScorers();
  }
  drawer.drawit(player.get_a_width(), player.get_c_width(), player.get_a_height(), player.get_c_height());
  if (player.getState() == Player.FINISHED) {
    noLoop();
  }
}

void mouseReleased() {
  player.mouseReleased();
}

void mousePressed() {
  player.mousePressed();
}

