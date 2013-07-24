import java.util.ArrayList;

public class Player {

  // Constants
  final static int INIT = 0;
  final static int PLAYING = 1;
  final static int SIMULATING = 2;
  final static int TIMEOUT = 3;
  final static int FINISHED = 4;
  final static int MENU = -1;

  final static int MAX_TIMER = 125;

  // Constructor
  public Player(int a_width, int c_width, int a_height, int c_height, int max_grid_x, int max_grid_y) {
    this.a_width = a_width;
    this.c_width = c_width;
    this.a_height = a_height;
    this.c_height = c_height;
    this.max_grid_x = max_grid_x;
    this.max_grid_y = max_grid_y;
    this.level = 1;

    // Create Board
    board = new Board(level, max_grid_x, max_grid_y);
    
    // Create initial state
    state = MENU;

    // Create buttons  
    int button_x = a_width;
    int play_y = c_height;
    int undo_y = c_height * 4;
    int reset_y = (int)(c_height * 7.5);
    int button_width = width - a_width - c_width;
    int button_height = c_width * 2;
    play_button = new CoinButton(button_x, play_y, button_width, button_height, "play");
    undo_button = new CoinButton(button_x, undo_y, button_width, button_height, "undo");
    reset_button = new CoinButton(button_x, reset_y, button_width, button_height, "reset");

    // Create timer
    int timer_x = a_width;
    int timer_y = (int)(a_height * 0.9);
    timer = new Timer(timer_x, timer_y, MAX_TIMER);
    
    // Create Scorers for multiple entities
    int scorer_x = a_width;
    int coin_scorer_y = (int)(a_height * 0.5);
    int gem_scorer_y = coin_scorer_y + 2 * this.c_height;
    int diamond_scorer_y = gem_scorer_y + 2 * this.c_height;
    int rock_scorer_y = diamond_scorer_y + 2 * this.c_height;
    coin_scorer = new Scorer(scorer_x, coin_scorer_y, (int)(1.5 * c_width), (int)(1.5 * c_height), G_COIN_IMAGE);
    gem_scorer = new Scorer(scorer_x, gem_scorer_y, (int)(1.5 * c_width), (int)(1.5 * c_height), G_GEM_IMAGE);
    diamond_scorer = new Scorer(scorer_x, diamond_scorer_y, (int)(1.5 * c_width), (int)(1.5 * c_height), G_DIAMOND_IMAGE);
    rock_scorer = new Scorer(scorer_x, rock_scorer_y, (int)(1.5 * c_width), (int)(1.5 * c_height), G_ROCK_IMAGE);
    
    // Create Menu screen
    this.menu = new Menu(a_width, c_width, a_height, c_height);
  }

  // Getters
  public int get_a_width() { 
    return a_width;
  }
  public int get_c_width() { 
    return c_width;
  }
  public int get_a_height() { 
    return a_height;
  }
  public int get_c_height() { 
    return c_height;
  }
  public boolean[][] getAlive() { 
    return board.getAlive();
  }
  public boolean[][] getEverAlive() { 
    return board.getEverAlive();
  }
  public boolean[][] getGemPositions() {
    return board.getGemPositions();
  }
  public boolean[][] getDiamondPositions() {
    return board.getDiamondPositions();
  }
  public boolean[][] getRockPositions() {
    return board.getRockPositions();
  }
  public boolean[][] getHitPositions() {
    return board.getHitPositions();
  }
  public CoinButton get_play_button() { 
    return play_button;
  }
  public CoinButton get_undo_button() { 
    return undo_button;
  }
  public CoinButton get_reset_button() { 
    return reset_button;
  }
  public Timer getTimer() { 
    return timer;
  }
  public Scorer getCoinScorer() { 
    return coin_scorer;
  }
  public Scorer getGemScorer() { 
    return gem_scorer;
  }
  public Scorer getDiamondScorer() { 
    return diamond_scorer;
  }
  public Scorer getRockScorer() { 
    return rock_scorer;
  }
  public Menu getMenu() {
    return menu;
  }
  public int getState() {
    return state;
  }
  
  //Setters
  public void setState(int st) {
    this.state = st;
  }
  
  // Place a coin on cell
  public void placeCoin() {
    if (state != PLAYING) return;
    board.placeCoin();
  }

  // Responds to undo press by user
  public void undo() {
    if (state != PLAYING) return;
    board.undo();
  }

  // Responds to reset pressed by user
  public void reset() {
    if (state != PLAYING) return;
    board.reset();
  }

  // Simulate the board
  public void simulate() {
    if (state != SIMULATING) return;
    
    // Simulate the board
    int[] score_increments = board.simulate();
    coin_scorer.incrementMaxScore(score_increments[0]);
    gem_scorer.incrementMaxScore(score_increments[1]);
    diamond_scorer.incrementMaxScore(score_increments[2]);
    rock_scorer.incrementMaxScore(score_increments[3]);
    
    // Advance time for timer, check if it has timed out and set the state
    if (timer.isTimeout()) 
      state = TIMEOUT;
    else
      timer.advanceit();
  }

  // All interactions with mouse pressed
  public void mouseReleased() {
    if (state == MENU && menu.getStartButton().mouseReleased()) {
      state = INIT;
      return;
    }
    //if (state != INIT && state != PLAYING) return;
    
    if (play_button.mouseReleased()) {
      state = SIMULATING;
    }
    else if (undo_button.mouseReleased()) {
      state = PLAYING;
      undo();
    }
    else if (reset_button.mouseReleased()) {
      state = PLAYING;
      reset();
    }
    else if (mouseX >= c_width && mouseX <= a_width - c_width && mouseY >= c_height && mouseY <= a_height - c_height) {
      state = PLAYING;
      placeCoin();
    }
  }
  
  // Advance scorer after timeout
  public void advanceScorers() {
    while (!coin_scorer.reachedMaxScore()) 
      coin_scorer.incrementScore(1);
    while (!gem_scorer.reachedMaxScore()) 
      gem_scorer.incrementScore(1);
    while (!diamond_scorer.reachedMaxScore()) 
      diamond_scorer.incrementScore(1);
    while (!rock_scorer.reachedMaxScore()) 
      rock_scorer.incrementScore(1);
    state = FINISHED;
  }
  
  public void mousePressed() {
    play_button.mousePressed();
    undo_button.mousePressed();
    reset_button.mousePressed();
    menu.getStartButton().mousePressed();
  }
  // Private
  // Dimensions of grid
  private int max_grid_x, max_grid_y;
  // Dimensions of arena
  private int a_width, a_height;
  // Dimensions of cell
  private int c_width, c_height;

  // Level
  private int level;
  
  // Maintain the state
  private int state;
 
  // Board
  private Board board;
  
  // Buttons
  private CoinButton play_button, undo_button, reset_button;

  // Timer to check if game has ended
  private Timer timer;
     
  // Scorer
  private Scorer coin_scorer, gem_scorer, diamond_scorer, rock_scorer;

  // Menu
  private Menu menu;  
}

