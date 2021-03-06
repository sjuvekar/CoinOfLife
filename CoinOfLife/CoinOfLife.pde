  /* @pjs preload="coin.png, button.png, active_button.png, gem.png, diamond.png, rock.png, logo.png, soundon.png, soundoff.png, 0.png, 1.png, 2.png, 3.png, 4.png, 5.png, 6.png, 7.png, 8.png, 9.png"; crisp="true"; */                 
/* @pjs preload="play.wav, coin.wav"; */
/* @pjs font="data/Clock.ttf, data/Button.ttf"; crisp=true; */ 
Player player;
Drawer drawer;
TutDrawer tut_drawer;

PImage G_COIN_IMAGE, G_BUTTON_IMAGE, G_ACTIVE_BUTTON_IMAGE, G_GEM_IMAGE, G_DIAMOND_IMAGE, G_ROCK_IMAGE, G_HIT_IMAGE, G_LOGO_IMAGE, G_SOUNDON_IMAGE, G_SOUNDOFF_IMAGE;
PImage[] G_DIGIT_IMAGES;

PFont G_CLOCK_FONT, G_BUTTON_FONT, G_TUT_FONT;

// Audio Setting
// Maxims
Maxim G_PLAY_MAXIM;

// AudioPlayers
AudioPlayer G_PLAY_PLAYER, G_COIN_PLAYER;

// Timer for playing coin sound
int G_TIMER;

// Global sound State
boolean G_SOUND_STATE;

void setup() {
  // Setting up background and colors
  background(0);
  size(1240, 768);
  frameRate(30);
  orientation(LANDSCAPE);
  //stroke(255);
  
  // Preload images
  G_COIN_IMAGE = loadImage("coin.png");
  G_BUTTON_IMAGE = loadImage("button.png");
  G_ACTIVE_BUTTON_IMAGE = loadImage("active_button.png");
  
  G_DIGIT_IMAGES = new PImage[10];
  for (int i = 0; i < 10; i++)
    G_DIGIT_IMAGES[i] = loadImage(i + ".png");
  G_GEM_IMAGE = loadImage("gem.png");
  G_DIAMOND_IMAGE = loadImage("diamond.png");
  G_ROCK_IMAGE = loadImage("rock.png");
  G_HIT_IMAGE = loadImage("hit.png");

  G_LOGO_IMAGE = loadImage("logo.png");
  
  // Sound images
  G_SOUNDON_IMAGE = loadImage("soundon.png");
  G_SOUNDOFF_IMAGE = loadImage("soundoff.png");
  
  // Preload font
  G_CLOCK_FONT = createFont("Clock.ttf", 48);
  G_BUTTON_FONT = createFont("Button.ttf", 24);
  G_TUT_FONT = createFont("fantasy", 20);
  
  // Create Maxim and AudioPlayers
  G_PLAY_MAXIM = new Maxim(this);
  
  G_PLAY_PLAYER = G_PLAY_MAXIM.loadFile("play.wav");
  G_COIN_PLAYER = G_PLAY_MAXIM.loadFile("coin.wav");
  G_PLAY_PLAYER.setLooping(false);
  G_COIN_PLAYER.setLooping(false);
  
  // Set Sound State
  G_SOUND_STATE = true;
  
  int a_width = arena_width();
  int c_width = cell_width();
  int a_height = arena_height();
  int c_height = cell_height();
  int max_grid_x = max_grid_X();
  int max_grid_y = max_grid_Y();
  player = new Player(a_width, c_width, a_height, c_height, max_grid_x, max_grid_y);
  drawer = new Drawer(player);
  tut_drawer = new TutDrawer(player);
}

void draw() {
  if (player.getState() == Player.MENU) {
    player.getMenu().display();
  }
  else if (player.getState() == Player.NEXTLEVEL) {
    player.getGlobalMenu().display(player.getLevel());
  }
  else if (player.getState() >= Player.TUT) {
    if (player.getState() == Player.TUT_SIMULATING) 
      player.simulate();
    tut_drawer.drawit(player.get_a_width(), player.get_c_width(), player.get_a_height(), player.get_c_height());
  }
  else {
    if (player.getState() == Player.SIMULATING) { 
      player.simulate();
    }
    if (player.getState() == Player.TIMEOUT) {
      player.advanceScorers();
    }
    if (player.getState() == Player.FINISHED) {
      player.waitForNextLevel();
    }
    drawer.drawit(player.get_a_width(), player.get_c_width(), player.get_a_height(), player.get_c_height());
  }
}

void mouseReleased() {
  player.mouseReleased();
}

void mousePressed() {
  player.mousePressed();
}

