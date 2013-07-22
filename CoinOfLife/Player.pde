import java.util.ArrayList;

public class Player {

  // Constants
  final static int INIT = 0;
  final static int PLAYING = 1;
  final static int SIMULATING = 2;
  final static int TIMEOUT = 3;
  final static int FINISHED = 4;

  final static int MAX_TIMER = 100;

  // Constructor
  public Player(int a_width, int c_width, int a_height, int c_height, int max_grid_x, int max_grid_y) {
    this.a_width = a_width;
    this.c_width = c_width;
    this.a_height = a_height;
    this.c_height = c_height;
    this.max_grid_x = max_grid_x;
    this.max_grid_y = max_grid_y;
    
    // Declare arrays
    alive = new boolean[max_grid_x+2][max_grid_y+2];
    ever_alive = new boolean[max_grid_x+2][max_grid_y+2];
    gem_positions = new int[max_grid_x+2][max_grid_y+2];
    
    for (int i = 0; i < max_grid_x; i++) {
      for (int j = 0; j < max_grid_y; j++) {
        alive[i][j] = false;
        ever_alive[i][j] = false;
        gem_positions[i][j] = 0;
      }
    }
    last_X = new ArrayList();
    last_Y = new ArrayList();

    // Create initial state
    state = INIT;

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
    return alive;
  }
  public boolean[][] getEverAlive() { 
    return ever_alive;
  }
  public int[][] getGemPositions() {
    return gem_positions;
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
  public int getState() {
    return state;
  }
  // Place a coin on cell
  public void placeCoin() {
    if (state != PLAYING) return;
    int c_width = cell_width();
    int c_height = cell_height();
    int i = (int) (mouseX /  c_width);
    int j = (int) (mouseY / c_height);
    alive[i][j] = true;
    ever_alive[i][j] = true;
    last_X.add(0, i);
    last_Y.add(0, j);
  }

  // Responds to undo press by user
  public void undo() {
    if (state != PLAYING) return;
    int lx = last_X.get(0);
    int ly = last_Y.get(0);
    alive[lx][ly] = false;
    ever_alive[lx][ly] = false;
    last_X.remove(0);
    last_Y.remove(0);
  }

  // Responds to reset pressed by user
  public void reset() {
    if (state != PLAYING) return;
    for (int i = 0; i < max_grid_x; i++) {
      for (int j = 0; j < max_grid_y; j++) {
        alive[i][j] = false;
        ever_alive[i][j] = false;
      }
    }
    while (!last_X.isEmpty ()) {
      last_X.remove(0);
      last_Y.remove(0);
    }
  }

  // Check if a cell is alive
  private boolean isAlive(int c_i, int c_j) {
    int alive_neighbors = 0;
    
    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        if (i == 0 && j == 0) {
          continue;
        }
        int new_ci = (c_i + i) % max_grid_x;
        int new_cj = (c_j + j) % max_grid_y;
        // Adjust the indices if out of arena
        if (new_ci < 1) {
          new_ci += max_grid_x;
        }
        if (new_cj < 1) {
          new_cj += max_grid_y;
        }

        if (alive[new_ci][new_cj]) {
          alive_neighbors++;
        }
      }
    }
    return ((alive[c_i][c_j] && alive_neighbors == 2) || alive_neighbors == 3);
  }


  public void simulate() {
    if (state != SIMULATING) return;
    boolean temp_alive[][] = new boolean[max_grid_x+2][max_grid_y+2];
    for (int i = 1; i <= max_grid_x; i++) {
      for (int j = 1; j <= max_grid_y; j++) {
        if (isAlive(i, j)) {
          temp_alive[i][j] = true;
          if (!ever_alive[i][j]) {
            ever_alive[i][j] = true;
            coin_scorer.incrementMaxScore();
          }
        }
        else
          temp_alive[i][j] = false;
      }
    }  
    arrayCopy(temp_alive, alive);
    // Advance time for timer, check if it has timed out and set the state
    if (timer.isTimeout()) 
      state = TIMEOUT;
    else
      timer.advanceit();
  }

  // All interactions with mouse pressed
  public void mouseReleased() {
    if (state != INIT && state != PLAYING) return;
    
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
    if (advanceScorer(coin_scorer))
      if (advanceScorer(gem_scorer))
        if (advanceScorer(diamond_scorer))
          if (advanceScorer(rock_scorer))  
            state = FINISHED;  
  }
  
  public boolean advanceScorer(Scorer my_scorer) {
    my_scorer.incrementScore();
    if (my_scorer.getScore() == my_scorer.getMaxScore())
      return true;
    else 
      return false;
  }
  
  public void mousePressed() {
    play_button.mousePressed();
    undo_button.mousePressed();
    reset_button.mousePressed();
  }
  // Private
  // Dimensions of grid
  private int max_grid_x, max_grid_y;
  // Dimensions of arena
  private int a_width, a_height;
  // Dimensions of cell
  private int c_width, c_height;

  // Arrays to check if a cell is dead/alive
  private boolean alive[][];
  private boolean ever_alive[][];
  private ArrayList<Integer> last_X, last_Y;

  // Gems and Rocks on the grid
  private int gem_positions[][]; 
  
  // Maintain the state
  private int state;
 
  // Buttons
  private CoinButton play_button, undo_button, reset_button;

  // Timer to check if game has ended
  private Timer timer;
     
  // Scorer
  private Scorer coin_scorer, gem_scorer, diamond_scorer, rock_scorer;
}

