/** Global Constants **/
// One image to be drawn at every location
/* @pjs preload="images/coin.png"; */
PImage COIN_IMAGE;

// Dead or Alive array
boolean IS_ALIVE_ARRAY[][];
boolean IS_EVER_ALIVE_ARRAY[][];

// Position of last coin. Used in undo
int LAST_IMG_X, LAST_IMG_Y;

// Flag to set simulation to true when 'play' is pressed
boolean SIMULATE_FLAG;

// Timer to keep track of progess
int TIMER;

// Maximum timer. stop draw()ing after timer reaches this value
int MAX_TIMER;

// Button parameters
int PLAY_X, PLAY_Y, UNDO_X, UNDO_Y, RESET_X, RESET_Y;
int BUTTON_WIDTH, BUTTON_HEIGHT, BUTTON_CURVATURE;

// Cells covered during the game
int CELLS_COVERED;

// Timer Position
int TIMER_X, TIMER_Y;

void setup() {
  /** Set the values of global constants **/
  reset();

  SIMULATE_FLAG = false;
  TIMER = 0;
  MAX_TIMER = 200;
  CELLS_COVERED = 0;

  COIN_IMAGE = loadImage("images/coin.png");
  IS_ALIVE_ARRAY = new boolean[max_grid_X()+2][max_grid_Y()+2];
  IS_EVER_ALIVE_ARRAY = new boolean[max_grid_X()+2][max_grid_Y()+2];
}

void draw() {
  if (SIMULATE_FLAG) {
    advanceCells();
    TIMER++;
    if (TIMER >= MAX_TIMER)
      noLoop();
  }
}

void mousePressed() {
  if (insidePlay()) { 
    SIMULATE_FLAG = true;
  }
  else if (insideUndo()) {
    undo();
  }
  else if (insideReset()) {
    reset();
  }
  else {
    int ARENA_WIDTH = arena_width();
    int CELL_WIDTH = cell_width();
    int ARENA_HEIGHT = arena_height();
    int CELL_HEIGHT = cell_height();  

    if (mouseX >= CELL_WIDTH && mouseX <= ARENA_WIDTH - CELL_WIDTH && mouseY >= CELL_HEIGHT && mouseY <= ARENA_HEIGHT - CELL_HEIGHT) {
      if (!SIMULATE_FLAG) 
        placeCoin();
    }
  }
}

void createButton(int x, int y, String s) {
  int ARENA_WIDTH = arena_width();
  int CELL_WIDTH = cell_width();
  int CELL_HEIGHT = cell_height();
  stroke(255);
  fill(0);
  rect(x, y, BUTTON_WIDTH, BUTTON_HEIGHT, BUTTON_CURVATURE);
  fill(255);
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
      if (i == 0 && j == 0)
        continue;
      int new_ci = (c_i + i) % MAX_X;
      int new_cj = (c_j + j) % MAX_Y;
      // Adjust the indices if out of arena
      if (new_ci < MIN_X)
        new_ci += MAX_X;
      if (new_cj < MIN_Y)
        new_cj += MAX_Y;

      if (IS_ALIVE_ARRAY[new_ci][new_cj])
        alive_neighbors++;
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
        if (!IS_EVER_ALIVE_ARRAY[i][j])
          CELLS_COVERED++;
        IS_EVER_ALIVE_ARRAY[i][j] = true;
      }
      else
        TEMP_IS_ALIVE_ARRAY[i][j] = false;
    }
  }
  
  arrayCopy(TEMP_IS_ALIVE_ARRAY, IS_ALIVE_ARRAY);
  drawCoins();
}
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
  
  for (int i = min_grid_X(); i <= max_grid_X(); i++)
    for (int j = min_grid_Y(); j <= max_grid_Y(); j++)
      if (IS_EVER_ALIVE_ARRAY[i][j]) {
        fill(50, 50, 50);
        rect(i * CELL_WIDTH, j * CELL_HEIGHT, CELL_WIDTH, CELL_HEIGHT);
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
  drawCoins();
}


