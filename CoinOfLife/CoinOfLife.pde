Player player;
Drawer drawer;

void setup() {
  // Setting up background and colors
  background(0);
  size(640, 480);
  stroke(255);

  int a_width = arena_width();
  int c_width = cell_width();
  int a_height = arena_height();
  int c_height = cell_height();
  int max_grid_x = max_grid_X();
  int max_grid_y = max_grid_Y();
  player = new Player(a_width, c_width, a_height, c_height, max_grid_x, max_grid_y);
  drawer = new Drawer(player);
}

void draw() {
  if (player.getState() !=  Player.TIMEOUT) {
    if (player.getState() == player.SIMULATING) 
      player.simulate();
    drawer.drawit(player.get_a_width(), player.get_c_width(), player.get_a_height(), player.get_c_height());
  }
  else if (player.getState() == Player.TIMEOUT) {
    noLoop();
  }
}

void mousePressed() {
  player.play();
}

