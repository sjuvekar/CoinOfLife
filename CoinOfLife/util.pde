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
  return (int)(arena_width() / cell_width()) - 2;
}

int max_grid_Y() {
  return (int)(arena_height() / cell_height()) - 2;
}

int min_grid_X() {
  return 1;
}

int min_grid_Y() {
  return 1;
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

  for (int i = CELL_WIDTH; i < ARENA_WIDTH; i += CELL_WIDTH) { 
    line(i, CELL_HEIGHT, i, ARENA_HEIGHT - CELL_HEIGHT);
  }

  for (int i = CELL_HEIGHT; i < ARENA_HEIGHT; i += CELL_HEIGHT) {
    line(CELL_WIDTH, i, ARENA_WIDTH - CELL_WIDTH, i);
  }
  
  TIMER_X = (int) (ARENA_WIDTH);
  TIMER_Y = (int) (ARENA_HEIGHT * 0.9);
  PLAY_X = TIMER_X;
  PLAY_Y = CELL_HEIGHT;
  UNDO_X = TIMER_X;
  UNDO_Y = CELL_HEIGHT * 4;
  RESET_X = TIMER_X;
  RESET_Y = (int)(CELL_HEIGHT * 7.5);
  BUTTON_WIDTH = width - ARENA_WIDTH - CELL_WIDTH;
  BUTTON_HEIGHT = CELL_WIDTH * 2;
  BUTTON_CURVATURE = CELL_WIDTH;
  SCORE_X = TIMER_X;
  SCORE_Y = (int)(TIMER_Y / 2);
  SCORE_WIDTH = CELL_WIDTH * 2;
  SCORE_HEIGHT = CELL_HEIGHT * 2;
  
  // Create Buttons
  createButton(PLAY_X, PLAY_Y, "Play");
  createButton(UNDO_X, UNDO_Y, "Undo");
  createButton(RESET_X, RESET_Y, "Reset");
  
  // Place the timer 
  fill(255);
  textSize(20);
  text("Time", TIMER_X, TIMER_Y);
  fill(0, 255, 0);
  if (MAX_TIMER == 0) {
    rect(TIMER_X, TIMER_Y + CELL_HEIGHT, width - ARENA_WIDTH - CELL_WIDTH, CELL_HEIGHT);
  }
  else {
    rect(TIMER_X, TIMER_Y + CELL_HEIGHT, (int)( (width - ARENA_WIDTH - CELL_WIDTH) * (MAX_TIMER - TIMER) / MAX_TIMER), CELL_HEIGHT);
  }
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
      if (IS_EVER_ALIVE_ARRAY[i][j]) {
        fill(50, 50, 50);
        rect(i * CELL_WIDTH, j * CELL_HEIGHT, CELL_WIDTH, CELL_HEIGHT);
      }
    }
  }
  
  for (int i = min_grid_X(); i <= max_grid_X(); i++) {
    for (int j = min_grid_Y(); j <= max_grid_Y(); j++) {
      if (IS_ALIVE_ARRAY[i][j]) {
        imageMode(CORNER);
        image(COIN_IMAGE, i * CELL_WIDTH, j * CELL_HEIGHT, CELL_WIDTH, CELL_HEIGHT);
      }
    }
  }
}


/***
 * Undo the last placed coin. 
 * TODO: Can only be called once
 ***/
void undo() {
  IS_ALIVE_ARRAY[LAST_IMG_X][LAST_IMG_Y] = false;
  IS_EVER_ALIVE_ARRAY[LAST_IMG_X][LAST_IMG_Y] = false;
  drawCoins();
}

