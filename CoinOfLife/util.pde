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
  return arena_width() / cell_width() + 1;
}

int max_grid_Y() {
  return arena_height() / cell_height() + 1;
}

void setGrid() {
  // Setting up background and colors
  background(0);
  size(640, 480);
  stroke(255);
  
  int a_w = arena_width();
  int c_w = cell_width();
  int a_h = arena_height();
  int c_h = cell_height();
  
  for (int i = 0; i <= a_w; i += c_w) 
     line(i, 0, i, a_h);
 
  for (int i = 0; i <= a_h; i += c_h)
     line(0, i, a_w, i);

}
