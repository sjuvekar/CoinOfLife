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

