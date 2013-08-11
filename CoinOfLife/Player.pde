import java.util.ArrayList;

public class Player {

  // Constants
  final static int INIT = 0;
  final static int PLAYING = 1;
  final static int SIMULATING = 2;
  final static int TIMEOUT = 3;
  final static int FINISHED = 4;
  final static int TUT = 5;
  final static int TUT_PLAYING = 6;
  final static int TUT_READY = 7;
  final static int TUT_SIMULATING = 8;
  final static int TUT_TIMEOUT = 9;
  
  final static int MENU = -1;
  final static int NEXTLEVEL = -2;
  final static int STORE_INIT = -3;

  final static int MAX_TIMER = 90;

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
    int play_y = (int)(c_height / 2);
    int undo_y = c_height * 2;
    int reset_y = (int)(c_height / 2 * 7.5);
    int button_width = width - a_width - c_width;
    int button_height = c_width;
    play_button = new CoinButton(button_x, play_y, button_width, button_height, "Play");
    undo_button = new CoinButton(button_x, undo_y, button_width, button_height, "Undo");
    reset_button = new CoinButton(button_x, reset_y, button_width, button_height, "Reset");
    goback_button = new CoinButton(button_x, play_y, button_width, button_height, "Main Menu");

    // Create timer
    int timer_x = a_width;
    int timer_y = (int)(a_height * 0.9);
    timer = new Timer(timer_x, timer_y, MAX_TIMER);
    
    // Create Scorers for multiple entities
    int scorer_x = a_width;
    int coin_scorer_y = (int)(a_height * 0.425);
    int gem_scorer_y = coin_scorer_y + (int)(1.5 * c_height);
    int diamond_scorer_y = gem_scorer_y + (int)(1.5 * c_height);
    int rock_scorer_y = diamond_scorer_y + (int)(1.5 * c_height);
    coin_scorer = new Scorer(scorer_x, coin_scorer_y, c_width, c_height, G_COIN_IMAGE);
    gem_scorer = new Scorer(scorer_x, gem_scorer_y, c_width, c_height, G_GEM_IMAGE);
    diamond_scorer = new Scorer(scorer_x, diamond_scorer_y, c_width, c_height, G_DIAMOND_IMAGE);
    rock_scorer = new Scorer(scorer_x, rock_scorer_y, c_width, c_height, G_ROCK_IMAGE);
    
    // Create Menu screen
    this.menu = new Menu(a_width, c_width, a_height, c_height);
    
    // Create the global menu screen
    this.global_menu = new GlobalMenu(a_width, c_width, a_height, c_height);
    
    // Create Store drawer
    store_drawer = new StoreDrawer(a_width, c_width, a_height, c_height);
    
    init();
  }

  // Init method to init things after next level pressed
  public void init() {
    board.init(this.level);
    timer.init(MAX_TIMER);
    coin_scorer.init();
    gem_scorer.init();
    diamond_scorer.init();
    rock_scorer.init();
    L_OK_TO_PLAY = true;  
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
  public CoinButton get_goback_button() { 
    return goback_button;
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
  public GlobalMenu getGlobalMenu() {
    return global_menu;
  }
  public int getLevel() {
    return level;
  }
  public int getState() {
    return state;
  }
  public boolean get_tut_wrong() {
    return TUT_WRONG;
  }
  public StoreDrawer getStoreDrawer() {
    return store_drawer;
  }
  
  //Setters
  public void setState(int st) {
    this.state = st;
  }
  
  // Place a coin on cell
  public void placeCoin() {
    if (state != PLAYING && state != TUT_PLAYING) return;
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

  // Check if all coins filled
  private boolean allTutCoinsFilled() {
      boolean[][] tempAlive = getAlive();
      int my_count = 0;
      for (int i = 0; i < tempAlive.length; i++) 
        for (int j = 0; j < tempAlive[i].length; j++)
         if (tempAlive[i][j])
            my_count++;
      return my_count == TUT_POS_X.length;
  }
  
  // Simulate the board
  public void simulate() {
    if (state != SIMULATING && state != TUT_SIMULATING) return;
    if (G_SOUND_STATE && L_OK_TO_PLAY) {
      G_PLAY_PLAYER.play();
      L_OK_TO_PLAY = false;
    }
    
    // Simulate the board
    int[] score_increments = board.simulate();
    coin_scorer.incrementMaxScore(score_increments[0]);
    gem_scorer.incrementMaxScore(score_increments[1]);
    diamond_scorer.incrementMaxScore(score_increments[2]);
    rock_scorer.incrementMaxScore(score_increments[3]);
    
    // Advance time for timer, check if it has timed out and set the state
    if (timer.isTimeout()) {
      if (state == SIMULATING) 
        state = TIMEOUT;
      else
        state = TUT_TIMEOUT;
    }
    else
      timer.advanceit();
  }

  // All interactions with mouse pressed
  public void mouseReleased() {
    if (state == MENU && menu.getStartButton().mouseReleased()) {
      state = INIT;
    }

    else if (state == MENU && menu.getTutButton().mouseReleased()) {
      state = TUT;
      init();
    }
    else if ( (state == TUT || state == TUT_PLAYING) && mouseX >= c_width && mouseX <= a_width - c_width && mouseY >= c_height && mouseY <= a_height - c_height) {
      state = TUT_PLAYING;
      boolean flag = false;
      int my_X = (int) (mouseX /  c_width);
      int my_Y = (int) (mouseY / c_height);
      // Check if inside Red Square
      for (int i = 0; i < TUT_POS_X.length; i++) {
        if (TUT_POS_X[i] == my_X && TUT_POS_Y[i] == my_Y) {
          flag = true;
          break;
        }
      }
      if (flag) {
        placeCoin();
        TUT_WRONG = false;
      }
      else
        TUT_WRONG = true;
      if (allTutCoinsFilled())
         state = TUT_READY;     
    }
    else if ((state == TUT || state == TUT_PLAYING) && play_button.mouseReleased()) {
      TUT_WRONG = true;
    }
    else if (state == TUT_READY && play_button.mouseReleased()) {
      state = TUT_SIMULATING;
    }
    else if (state == TUT_TIMEOUT && goback_button.mouseReleased()) {
      state = MENU;
      init();
    }
    else if ((state == MENU && menu.getStoreButton().mouseReleased()) || (state == NEXTLEVEL && global_menu.getStoreButton().mouseReleased())) {
      state = STORE_INIT;
    }
    else if (state == STORE_INIT && store_drawer.getBackButton().mouseReleased()) {
      state = NEXTLEVEL;
      G_TIMER = 0;
    }   
    else if (state == MENU && menu.getSoundButton().mouseReleased()) {
      G_SOUND_STATE = !G_SOUND_STATE;
    }
    else if (state == NEXTLEVEL && global_menu.getContinueButton().mouseReleased()) {
      state = INIT;
      // Increment the level
      this.level = this.level + 1;
      init();
    }
    
    else if (state == NEXTLEVEL && global_menu.getSoundButton().mouseReleased()) {
      G_SOUND_STATE = !G_SOUND_STATE;
    }
    
    else if ((state == INIT || state == PLAYING) && play_button.mouseReleased()) {
      state = SIMULATING;
    }
    else if ((state == INIT || state == PLAYING) && undo_button.mouseReleased()) {
      state = PLAYING;
      undo();
    }
    else if ((state == INIT || state == PLAYING) && reset_button.mouseReleased()) {
      state = PLAYING;
      reset();
    }
    else if ((state == INIT || state == PLAYING) && mouseX >= c_width && mouseX <= a_width - c_width && mouseY >= c_height && mouseY <= a_height - c_height) {
      state = PLAYING;
      placeCoin();
    }
  }
  
  // Advance scorer after timeout
  public void advanceScorers() {
    G_PLAY_PLAYER.stop();
    G_TIMER = 0;
    
    while (!coin_scorer.reachedMaxScore()) 
      coin_scorer.incrementScore(1);
    while (!gem_scorer.reachedMaxScore()) 
      gem_scorer.incrementScore(1);
    while (!diamond_scorer.reachedMaxScore()) 
      diamond_scorer.incrementScore(1);
    while (!rock_scorer.reachedMaxScore()) 
      rock_scorer.incrementScore(1);
      
    // Set globalMenu
    global_menu.getCoinScorer().incrementScore(coin_scorer.getMaxScore());
    global_menu.getGemScorer().incrementScore(gem_scorer.getMaxScore());
    global_menu.getDiamondScorer().incrementScore(diamond_scorer.getMaxScore());
    global_menu.getRockScorer().incrementScore(rock_scorer.getMaxScore());
    
    // Set the state
    state = FINISHED;
  }
  
  // Busy wait for 100 units after FINISHED state
  public void waitForNextLevel() {
    if (G_TIMER == 10) {
      if (G_SOUND_STATE) {
        G_COIN_PLAYER.cue(0);
        G_COIN_PLAYER.play();
      }
      G_TIMER = G_TIMER + 1;
    }
    else if (G_TIMER >= 80) {
      state = NEXTLEVEL;
      G_TIMER = 0;
      G_COIN_PLAYER.stop();
    }  
    else {
      G_TIMER = G_TIMER + 1;
    }
  }
  
  public void mousePressed() {
    if (state != TUT_TIMEOUT && state!= STORE_INIT) {
      play_button.mousePressed(); 
      undo_button.mousePressed();
      reset_button.mousePressed();
    }
    if (state == MENU) {
      menu.getStartButton().mousePressed();
      menu.getTutButton().mousePressed();
      menu.getStoreButton().mousePressed();
    }
    if (state == NEXTLEVEL)
      global_menu.getContinueButton().mousePressed();
    if (state == TUT_TIMEOUT)
      goback_button.mousePressed();
    if (state == STORE_INIT) {
      store_drawer.getBackButton().mousePressed();
      store_drawer.coin_1000.mousePressed();
      store_drawer.coin_10000.mousePressed();
      store_drawer.gem_100.mousePressed();
      store_drawer.gem_1000.mousePressed();
      store_drawer.diamond_100.mousePressed();
      store_drawer.diamond_1000.mousePressed();
      store_drawer.rock_100.mousePressed();
      store_drawer.rock_1000.mousePressed(); 
    }
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
  private CoinButton play_button, undo_button, reset_button, goback_button;

  // Timer to check if game has ended
  private Timer timer;
     
  // Scorer
  private Scorer coin_scorer, gem_scorer, diamond_scorer, rock_scorer;

  // Menu
  private Menu menu;

  // global menu to display between levels
  private GlobalMenu global_menu;
  
  // Ok to play flag
  private boolean L_OK_TO_PLAY;
  
  // Tutorial wrong flag
  private boolean TUT_WRONG;
  
  // StoreDrawer
  private StoreDrawer store_drawer;
   
}

