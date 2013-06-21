
PImage[][] coin_images;

void setup() {
  setGrid();

  int a_w = arena_width();
  int c_w = cell_width();
  int a_h = arena_height();
  int c_h = cell_height();
  coin_images = new PImage[max_grid_X()][max_grid_Y()];
}

void draw() {
}

void mousePressed() {
  if (mouseX > arena_width()) { 
     play();
  }
  else {
    int c_w = cell_width();
    int c_h = cell_height();
    int c_i = mouseX /  c_w;
    int c_j = mouseY / c_h;
    coin_images[c_i][c_j] = loadImage("coin.png");
    imageMode(CORNER);
    image(coin_images[c_i][c_j], c_i * c_w, c_j * c_h, c_w, c_h);
  }
}

boolean is_alive(int c_i, int c_j) {
  int a_w = arena_width();
  int a_h = arena_height();

  int alive_neighbors = 0;
  for (int i = -1; i <= 1; i++) {
    for (int j = -1; j <= 1; j++) {
      if (i == 0 && j == 0)
        continue;
      int new_ci = c_i + i;
      int new_cj = c_j + j;
      if (new_ci >= 0 && new_cj >= 0 && new_ci < max_grid_X() && new_cj < max_grid_Y()) 
        if (coin_images[new_ci][new_cj] != null)
          alive_neighbors++;
    }
  }
  if ((coin_images[c_i][c_j] != null && alive_neighbors == 2) || alive_neighbors == 3)
    return true;
  else
    return false;
}

void play() {
  setGrid();
  int c_w = cell_width();
  int c_h = cell_height();
  PImage new_coin_images[][] = new PImage[max_grid_X()][max_grid_Y()];

  for (int i = 0; i < max_grid_X(); i++) {
    for (int j = 0; j < max_grid_Y(); j++) {
      if (is_alive(i, j)) {
        new_coin_images[i][j] = loadImage("coin.png");
        imageMode(CORNER);
        image(new_coin_images[i][j], i * c_w, j * c_h, c_w, c_h);
      }
    }
  }

  arrayCopy(new_coin_images, coin_images);
}

