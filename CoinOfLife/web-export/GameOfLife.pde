int cell_width = 32;
int cell_height;
int arena_width;
int arena_height;

void setup() {
  // Setting up background and colors
  background(0);
  size(640, 480);
  stroke(255);
  
  // Setting up arena width and size
  arena_width = (int)(width * 0.75);
  arena_height = height;
  
  cell_height = (int)(cell_width * float(arena_height) / float(arena_width));
  
  for (int i = 0; i <= arena_width; i += cell_width) 
     line(i, 0, i, arena_height);
 
  for (int i = 0; i <= arena_height; i += cell_height)
     line(0, i, arena_width, i);  
  
  for (int i = 0; i < arena_width; i += cell_width)
    for (int j = 0; j < arena_height; j += cell_height) {
      if (random(0, 1) > 0.5) {
        PImage coin_image = loadImage("coin.png");
        imageMode(CORNER);
        image(coin_image, i * cell_width, j * cell_height, cell_width, cell_height);
      }
    }  
}

