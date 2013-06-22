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
 * Use the rules of Game of life to check if the cell is alive in 
 * Next iteration. Loop back at the end of the screen in all directions
 ***/
boolean is_alive(int c_i, int c_j) {
  int alive_neighbors = 0;
  int MAX_X = max_grid_X();
  int MAX_Y = max_grid_Y();
  int MIN_X = min_grid_X();
  int MIN_Y = min_grid_Y();
  
  for (int i = -1; i <= 1; i++) {
    for (int j = -1; j <= 1; j++) {
      if (i == 0 && j == 0)
        continue;
      int new_ci = (c_i + i) % MAX_X;
      int new_cj = (c_j + j) % MAX_Y;
      // Adjust the indices if out of arena
      if (new_ci < MIN_X)
        new_ci += MAX_X;
      if (new_cj < MIN_Y)
        new_cj += MAX_Y;
      
      if (coin_images[new_ci][new_cj] != null)
        alive_neighbors++;
    }
  }
  if ((coin_images[c_i][c_j] != null && alive_neighbors == 2) || alive_neighbors == 3)
    return true;
  else
    return false;
}

