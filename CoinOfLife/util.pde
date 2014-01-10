int arena_width() {
  return (int)(width * 0.76);
}

int arena_height() {
  return height;
}

int cell_width() {
  if (height <= 240)
    return 20;
  if (height <= 480)
    return 40;
  return 54;
}

int cell_height() {
  //return (int)(cell_width() * float(arena_height()) / float(arena_width()));
  return cell_width();
}

int max_grid_X() {
  return (int)(arena_width() / cell_width()) - 2;
}

int max_grid_Y() {
  return (int)(arena_height() / cell_height()) - 1;
}

int min_grid_X() {
  return 1;
}

int min_grid_Y() {
  return 1;
}

final int[] TUT_POS_X = {7, 7, 8, 9, 9, 9};
final int[] TUT_POS_Y = {7, 6, 6, 6, 7, 8};
  

