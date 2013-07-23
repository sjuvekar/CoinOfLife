public class Board {
  
  public Board(int level, int max_grid_x, int max_grid_y) {
    this.level = level;
    this.max_grid_x = max_grid_x;
    this.max_grid_y = max_grid_y;
    // Declare arrays
    alive = new boolean[max_grid_x+2][max_grid_y+2];
    ever_alive = new boolean[max_grid_x+2][max_grid_y+2];
    gem_positions = new boolean[max_grid_x+2][max_grid_y+2];
    diamond_positions = new boolean[max_grid_x+2][max_grid_y+2];
    rock_positions = new boolean[max_grid_x+2][max_grid_y+2];
    hit_positions = new boolean[max_grid_x+2][max_grid_y+2];
    
    init();
  }
  
  public void init() {
    for (int i = 0; i < max_grid_x; i++) {
      for (int j = 0; j < max_grid_y; j++) {
        alive[i][j] = false;
        ever_alive[i][j] = false;
        gem_positions[i][j] = false;
        diamond_positions[i][j] = false;
        rock_positions[i][j] = false;
        hit_positions[i][j] = false;
      }
    }
    
    for (int i = 1; i < max_grid_x-1; i++) {
      for (int j = 1; j < max_grid_y-1; j++) {
        double r = random(0., 0.5);
        if (r < 0.002)
          gem_positions[i][j] = true;
        else if (r < 0.00208)
          diamond_positions[i][j] = true;
        else if (r < 0.00214)
          rock_positions[i][j] = true;
      }
    }
    // Randomly set gems
    last_X = new ArrayList();
    last_Y = new ArrayList();
  }
  
  // Getters
  public boolean[][] getAlive() { 
    return alive;
  }
  public boolean[][] getEverAlive() { 
    return ever_alive;
  }
  public boolean[][] getGemPositions() {
    return gem_positions;
  }
  public boolean[][] getDiamondPositions() {
    return diamond_positions;
  }
  public boolean[][] getRockPositions() {
    return rock_positions;
  }
  public boolean[][] getHitPositions() {
    return hit_positions;
  }
  
  public void placeCoin() {
    int c_width = cell_width();
    int c_height = cell_height();
    int i = (int) (mouseX /  c_width);
    int j = (int) (mouseY / c_height);
    if (gem_positions[i][j] || diamond_positions[i][j] || rock_positions[i][j])
      return;
    alive[i][j] = true;
    ever_alive[i][j] = true;
    last_X.add(0, i);
    last_Y.add(0, j);
  }
  
  // Responds to undo press by user
  public void undo() {
    int lx = last_X.get(0);
    int ly = last_Y.get(0);
    alive[lx][ly] = false;
    ever_alive[lx][ly] = false;
    last_X.remove(0);
    last_Y.remove(0);
  }
  
  // Responds to reset pressed by user
  public void reset() {
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
  public boolean isAlive(int c_i, int c_j) {
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
  
  
  // Simulate the board
  public int simulate() {
    int coin_increment = 0;
    int gem_increment = 0;
    int diamond_increment = 0;
    int rock_increment = 0;
    
    boolean temp_alive[][] = new boolean[max_grid_x+2][max_grid_y+2]; 
    for (int i = 1; i <= max_grid_x; i++) {
      for (int j = 1; j <= max_grid_y; j++) {
        if (isAlive(i, j)) {
          temp_alive[i][j] = true;
          if (gem_positions[i][j] || diamond_positions[i][j] || rock_positions[i][j]) {
            hit_positions[i][j] = true;
            if (gem_positions[i][j])
              gem_increment++;
            else if (diamond_positions[i][j])
              diamond_increment++;
            else if (rock_positions[i][j])
              rock_increment++;
          }
          gem_positions[i][j] = false;
          diamond_positions[i][j] = false;
          rock_positions[i][j] = false;
          
          if (!ever_alive[i][j]) {
            ever_alive[i][j] = true;
            coin_increment++;
          }
        }
        else {
          temp_alive[i][j] = false;
        }
      }
    }  
    arrayCopy(temp_alive, alive);
    
    // Create array
    return coin_increment;
  }
  
   
  // Level
  private int level;
  
  // Dimensions
  private int max_grid_x, max_grid_y;
  
  // Arrays to check if a cell is dead/alive
  private boolean alive[][];
  private boolean ever_alive[][];
  private ArrayList<Integer> last_X, last_Y;

  // Gems and Rocks on the grid
  private boolean gem_positions[][]; 
  private boolean diamond_positions[][];
  private boolean rock_positions[][];
 private boolean hit_positions[][]; 
}
