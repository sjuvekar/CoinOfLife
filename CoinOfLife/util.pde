int arena_width() {
  return (int)(width * 0.75);
}

int arena_height() {
  return height;
}

int cell_width() {
  return 16;
}

int cell_height() {
  return (int)(cell_width() * float(arena_height()) / float(arena_width()));
}

int max_grid_X() {
  return arena_width() / cell_width() - 2;
}

int max_grid_Y() {
  return arena_height() / cell_height() - 2;
}

int min_grid_X() {
  return 1;
}

int min_grid_Y() {
  return 1;
}

/***
 * Redraw the entire coin_images array
 ***/
void drawCoins() {
  reset();
  int CELL_WIDTH = cell_width();
  int CELL_HEIGHT = cell_height();  
  
  for (int i = min_grid_X(); i <= max_grid_X(); i++) {
    for (int j = min_grid_Y(); j <= max_grid_Y(); j++) {
      if (coin_images[i][j] != null) {
        imageMode(CORNER);
        image(coin_images[i][j], i * CELL_WIDTH, j * CELL_HEIGHT, CELL_WIDTH, CELL_HEIGHT);
      }
    }
  }
}


/***
 * Very important method. Call this method to clear the screen and redraw the grid
 ***/
void reset() {
  // Setting up background and colors
  background(0);
  size(640, 480);
  stroke(255);

  int ARENA_WIDTH = arena_width();
  int CELL_WIDTH = cell_width();
  int ARENA_HEIGHT = arena_height();
  int CELL_HEIGHT = cell_height();  

  for (int i = CELL_WIDTH; i < ARENA_WIDTH; i += CELL_WIDTH)  
    line(i, CELL_HEIGHT, i, ARENA_HEIGHT - CELL_HEIGHT);

  for (int i = CELL_HEIGHT; i < ARENA_HEIGHT; i += CELL_HEIGHT)
    line(CELL_WIDTH, i, ARENA_WIDTH - CELL_WIDTH, i);
}


/***
 * Undo the last placed coin. 
 * TODO: Can only be called once
 ***/
void undo() {
  coin_images[LAST_IMG_X][LAST_IMG_Y] = null;
  drawCoins();
}

