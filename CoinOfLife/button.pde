void createButton(int x, int y, String s) {
  int ARENA_WIDTH = arena_width();
  int CELL_WIDTH = cell_width();
  int CELL_HEIGHT = cell_height();
  stroke(255);
  //fill(0);
  //rect(x, y, BUTTON_WIDTH, BUTTON_HEIGHT, BUTTON_CURVATURE);
  //fill(255);
  image(BUTTON_IMAGE, x, y, BUTTON_WIDTH, BUTTON_HEIGHT);
  textSize(20);
  text(s, x + 3 * CELL_WIDTH, (int)(y + 1.5 * CELL_HEIGHT));
}

boolean insidePlay() {
  return (mouseX >= PLAY_X && mouseX <= PLAY_X + BUTTON_WIDTH && mouseY >= PLAY_Y && mouseY <= PLAY_Y + BUTTON_HEIGHT);
}

boolean insideUndo() {
  return (mouseX >= UNDO_X && mouseX <= UNDO_X + BUTTON_WIDTH && mouseY >= UNDO_Y && mouseY <= UNDO_Y + BUTTON_HEIGHT);
}

boolean insideReset() {
  return (mouseX >= RESET_X && mouseX <= RESET_X + BUTTON_WIDTH && mouseY >= RESET_Y && mouseY <= RESET_Y + BUTTON_HEIGHT);
}
