import java.util.ArrayList;

class Player {

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
  
  // Maintain the state
  private int state;
  final static int INIT = 0;
  final static int PLAYING = 1;
  final static int SIMULATING = 2;
  final static int TIMEOPUT = 3;

  // Buttons
  private Button play_button, undo_button, reset_button;
  
  // Timer to check if game has ended
  private Timer timer;
  final static int MAX_TIMER = 100;
  
  // Constructor
  public Player(int a_width, int c_width, int a_height, int c_height, int max_grid_x, int max_grid_y) {
    this.a_width = a_width;
    this.c_width = c_width;
    this.a_height = a_height;
    this.c_height = c_height;
    this.max_grid_x = max_grid_x;
    this.max_grid_y = max_grid_y;
    alive = new boolean[max_grid_x][max_grid_y];
    ever_alive = new boolean[max_grid_x][max_grid_y];
    for (int i = 0; i < max_grid_x; i++) {
      for (int j = 0; j < max_grid_y; j++) {
        alive[i][j] = false;
        ever_alive[i][j] = false;
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
    play_button = new Button(button_x, play_y, button_width, button_height, "Play");
    undo_button = new Button(button_x, undo_y, button_width, button_height, "Undo");
    reset_button = new Button(button_x, reset_y, button_width, button_height, "Reset");
    
    // Create timer
    int a_width = arena_width();
    int a_height = arena_height();
    int timer_x = a_width;
    int timer_y = (int)(a_height * 0.9);
    timer = new Timer(timer_x, timer_y, MAX_TIMER);
  }

  // Getters
  public int get_a_width() { return a_width; }
  public int get_c_width() { return c_width; }
  public int get_a_height() { return a_height; }
  public int get_c_height() { return c_height; }
  public boolean[][] getAlive() { return alive;}
  public boolean[][] getEverAlive() { return ever_alive; }
  public Button get_play_button() { return play_button; }
  public Button get_undo_button() { return undo_button; }
  public Button get_reset_button() { return reset_button; }
  public Timer getTimer() { return timer; }
  
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
    int max_x = alive.length;
    int max_y = alive[0].length;
    int min_x = min_grid_X();
    int min_y = min_grid_Y();

    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        if (i == 0 && j == 0) {
          continue;
        }
        int new_ci = (c_i + i) % max_x;
        int new_cj = (c_j + j) % max_y;
        // Adjust the indices if out of arena
        if (new_ci < min_x) {
          new_ci += max_x;
        }
        if (new_cj < min_y) {
          new_cj += max_y;
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
    boolean temp_alive[][] = new boolean[max_grid_x][max_grid_y];
  }
  
  // Most important method. Effectively keeps state
  public void play() {
  }
}

