/***
 * Implements the 'reset' button
 ***/
void resetPressed() {
  reset();
}

/***
 * Implements the 'undo' button
 ***/
void undoPressed() {
  undo();
}

/***
 * Place a coin at right co-ordinate given mous-click position
 ***/
void placeCoin() {
  int CELL_WIDTH = cell_width();
  int CELL_HEIGHT = cell_height();
  // Setup last position and alive array
  LAST_IMG_X =(int) (mouseX /  CELL_WIDTH);
  LAST_IMG_Y = (int) (mouseY / CELL_HEIGHT);
  IS_ALIVE_ARRAY[LAST_IMG_X][LAST_IMG_Y] = true;
  IS_EVER_ALIVE_ARRAY[LAST_IMG_X][LAST_IMG_Y] = true;
  // Draw the coin
  imageMode(CORNER);
  image(COIN_IMAGE, LAST_IMG_X * CELL_WIDTH, LAST_IMG_Y * CELL_HEIGHT, CELL_WIDTH, CELL_HEIGHT);
}


