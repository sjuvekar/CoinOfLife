  /** Global Constants **/
// One image to be drawn at every location
/* @pjs preload="images/coin.png, images/button.png, images/9.png,
                 images/0.png, images/1.png, images/2.png,
                 images/3.png, images/4.png, images/5.png,
                 images/6.png, images/7.png, images/8.png" ; */
PImage COIN_IMAGE, BUTTON_IMAGE;
PImage DIGIT_IMAGES[];

// Dead or Alive array
boolean IS_ALIVE_ARRAY[][];
boolean IS_EVER_ALIVE_ARRAY[][];

// Position of last coin. Used in undo
int LAST_IMG_X, LAST_IMG_Y;

// Flag to set simulation to true when 'play' is pressed
boolean SIMULATE_FLAG, ACHIEVEMENT_FLAG;

// Score
int SCORE;

// Timer to keep track of progess
int TIMER;

// Maximum timer. stop draw()ing after timer reaches this value
int MAX_TIMER;

// Button parameters
int PLAY_X, PLAY_Y, UNDO_X, UNDO_Y, RESET_X, RESET_Y;
int BUTTON_WIDTH, BUTTON_HEIGHT, BUTTON_CURVATURE;

// Score Parameters
int SCORE_X, SCORE_Y;
int SCORE_WIDTH, SCORE_HEIGHT;

// Cells covered during the game
int CELLS_COVERED;

// Timer Position
int TIMER_X, TIMER_Y;

// Audio player variables
//Maxim coinMaxim;
AudioPlayer coinPlacedPlayer;
AudioPlayer gameProgressedPlayer;
AudioPlayer achievementPlayer;

void setup() {
  /** Set the values of global constants **/
  COIN_IMAGE = loadImage("images/coin.png");
  BUTTON_IMAGE = loadImage("images/button.png");
  DIGIT_IMAGES = new PImage[10];
  for (int i = 0; i < 10; i++) {
    DIGIT_IMAGES[i] = loadImage("images/" + i + ".png");
  }
  
  reset();

  SIMULATE_FLAG = false;
  ACHIEVEMENT_FLAG = false;
  TIMER = 0;
  MAX_TIMER = 200;
  CELLS_COVERED = 0;
  SCORE = 0;
  
  IS_ALIVE_ARRAY = new boolean[max_grid_X()+2][max_grid_Y()+2];
  IS_EVER_ALIVE_ARRAY = new boolean[max_grid_X()+2][max_grid_Y()+2];
  
  // Audio Player settings
  //coinMaxim = new Maxim(this);
  //coinPlacedPlayer = maxim.loadfile();
  //gameProgressedPlayer = coinMaxim.loadFile("audio/game_progress.wav");
  //achievementPlayer = coinMaxim.loadFile("audio/achievement.wav");
  
  //coinPlayer.setLooping(false);
  //gameProgressedPlayer.setLooping(true);
  //achievementPlayer.setLooping(false);
}

void draw() {
  if (SIMULATE_FLAG) {
    //gameProgressedPlayer.play();
    if (TIMER >= MAX_TIMER) {
      //gameProgressedPlayer.stop();
      //achievementPlayer.play(); 
      if (ACHIEVEMENT_FLAG) {
        noLoop();
      }
      else {
        advanceScore();
      }
    }
    else {
      advanceCells();
      TIMER++;
    }
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
      if (!SIMULATE_FLAG) {
        placeCoin();
      }
      //coinPlacedPlayer.cue(0);
      //coinPlacedPlayer.play();
    }
  }
}

