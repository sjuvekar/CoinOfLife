/** Global Constants **/
// Image array at every iteration of simulation
PImage[][] coin_images;

// Position of last coin. Used in undo
int LAST_IMG_X, LAST_IMG_Y;

// Flag to set simulation to true when 'play' is pressed
boolean SIMULATE_FLAG;

void setup() {
  /** Set the values of global constants **/
  reset();
  SIMULATE_FLAG = false;
  coin_images = new PImage[max_grid_X()+2][max_grid_Y()+2];
}

void draw() {
  if (SIMULATE_FLAG) 
    simulate();
}

void mousePressed() {
  if (mouseX > arena_width() - cell_width()) { 
     SIMULATE_FLAG = true;
  }
  else if (mouseX >= cell_width() && mouseY >= cell_height() && mouseY <= arena_height() - cell_height()) {
    SIMULATE_FLAG = false;
    int c_w = cell_width();
    int c_h = cell_height();
    LAST_IMG_X = mouseX /  c_w;
    LAST_IMG_Y = mouseY / c_h;
    coin_images[LAST_IMG_X][LAST_IMG_Y] = loadImage("coin.png");
    imageMode(CORNER);
    image(coin_images[LAST_IMG_X][LAST_IMG_Y], LAST_IMG_X * c_w, LAST_IMG_Y * c_h, c_w, c_h);
  }
}

void simulate() {
  reset();
  int c_w = cell_width();
  int c_h = cell_height();
  PImage new_coin_images[][] = new PImage[max_grid_X()+2][max_grid_Y()+2];

  for (int i = min_grid_X(); i <= max_grid_X(); i++) {
    for (int j = min_grid_Y(); j <= max_grid_Y(); j++) {
      if (is_alive(i, j)) {
        new_coin_images[i][j] = loadImage("coin.png");
        imageMode(CORNER);
        image(new_coin_images[i][j], i * c_w, j * c_h, c_w, c_h);
      }
    }
  }

  arrayCopy(new_coin_images, coin_images);
}

