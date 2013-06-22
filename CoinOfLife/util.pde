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


