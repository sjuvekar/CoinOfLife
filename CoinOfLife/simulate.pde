/***
 * Use the rules of Game of life to check if the cell is alive in 
 * Next iteration. Wrap-around at the end of the screen in all directions
 ***/
boolean is_alive(int c_i, int c_j) {
  int alive_neighbors = 0;
  int MAX_X = max_grid_X();
  int MAX_Y = max_grid_Y();
  int MIN_X = min_grid_X();
  int MIN_Y = min_grid_Y();

  for (int i = -1; i <= 1; i++) {
    for (int j = -1; j <= 1; j++) {
      if (i == 0 && j == 0) {
        continue;
      }
      int new_ci = (c_i + i) % MAX_X;
      int new_cj = (c_j + j) % MAX_Y;
      // Adjust the indices if out of arena
      if (new_ci < MIN_X) {
        new_ci += MAX_X;
      }
      if (new_cj < MIN_Y) {
        new_cj += MAX_Y;
      }
      
      if (IS_ALIVE_ARRAY[new_ci][new_cj]) {
        alive_neighbors++;
      }
    }
  }
  return ((IS_ALIVE_ARRAY[c_i][c_j] && alive_neighbors == 2) || alive_neighbors == 3);
}

/***
 * Advance the cells by killing/reviving them to next round
 ***/
void advanceCells() {
  reset();
  
  int CELL_WIDTH = cell_width();
  int CELL_HEIGHT = cell_height();
  
  boolean TEMP_IS_ALIVE_ARRAY[][] = new boolean[max_grid_X()+2][max_grid_Y()+2];
  
  for (int i = min_grid_X(); i <= max_grid_X(); i++) {
    for (int j = min_grid_Y(); j <= max_grid_Y(); j++) {
      if (is_alive(i, j)) {
        TEMP_IS_ALIVE_ARRAY[i][j] = true;
        if (!IS_EVER_ALIVE_ARRAY[i][j]) {
          CELLS_COVERED++;
        }
        IS_EVER_ALIVE_ARRAY[i][j] = true;
      }
      else
        TEMP_IS_ALIVE_ARRAY[i][j] = false;
    }
  }
  
  arrayCopy(TEMP_IS_ALIVE_ARRAY, IS_ALIVE_ARRAY);
  drawCoins();
}

/***
 * Show an animation to advance score
 ***/
 void advanceScore() {
   int CELL_WIDTH = cell_width();
   int CELL_HEIGHT = cell_height();
   SCORE++;
   CELLS_COVERED--;
   
   if (CELLS_COVERED == 0) {
        ACHIEVEMENT_FLAG = true;
   }
   else {
     fill(0);
     stroke(0);
     rect(TIMER_X, TIMER_Y/2, width - TIMER_X, 2 * CELL_HEIGHT);
     int s = SCORE;
     int[] digits = {};
     while (s >= 0) {
       digits = append(digits, s % 10);
       s = (int)(s / 10);
       if (s == 0)
         break;
     }
     
     image(COIN_IMAGE, SCORE_X, SCORE_Y, SCORE_WIDTH, SCORE_HEIGHT);
     for (int j = digits.length - 1; j >= 0; j--) {
       image(DIGIT_IMAGES[digits[j]], SCORE_X + (digits.length - j) * SCORE_WIDTH, SCORE_Y, SCORE_WIDTH, SCORE_HEIGHT);
     }
   }
 }
