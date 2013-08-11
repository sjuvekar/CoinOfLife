public class StoreDrawer {
  
  public StoreDrawer(int a_width, int c_width, int a_height, int c_height) {
   
    int button_width = width - a_width - c_width;
    int button_height = c_height;
    int left_x = 300;
    int right_x = left_x + (int)(2.5 * button_width);
    int button_top = 100;
    
    coin_1000 = new CoinButton(left_x, button_top, button_width, button_height, "$1.99"); 
    coin_10000 = new CoinButton(right_x, button_top, button_width, button_height, "$15.99"); 
    gem_100 = new CoinButton(left_x, button_top + 2 * button_height, button_width, button_height, "$2.99"); 
    gem_1000 = new CoinButton(right_x, button_top + 2 * button_height, button_width, button_height, "$25.99"); 
    diamond_100 = new CoinButton(left_x, button_top + 4 * button_height, button_width, button_height, "$3.99"); 
    diamond_1000 = new CoinButton(right_x, button_top + 4 * button_height, button_width, button_height, "$35.99"); 
    rock_100 = new CoinButton(left_x, button_top + 6 * button_height, button_width, button_height, "$3.99"); 
    rock_1000 = new CoinButton(right_x, button_top + 6 * button_height, button_width, button_height, "$35.99");
    back_button = new CoinButton(width / 2 - button_width, button_top + 8 * button_height, button_width * 2, button_height * 2, "Back");
  }
 
  // drawit
  public void drawit(int a_width, int c_width, int a_height, int c_height) {
    // Setting up background and colors
    background(0);
    stroke(255);
    
    int top_y = coin_1000.getY();
    int left_x = coin_1000.getX();
    int button_width = coin_1000.getWidth();
    int button_height = coin_1000.getHeight();
    
    int left_image_x = 100;
    int left_text_x = 170;
    int right_image_x = left_x + (int)(1.5 * button_width);
    int right_text_x = left_x + (int)(1.8 * button_width);
    
    pushStyle();
    
    // Images
    imageMode(CORNER);
    image(G_COIN_IMAGE, left_image_x, top_y, 50, 50);
    image(G_COIN_IMAGE, right_image_x, top_y, 50, 50);
    image(G_GEM_IMAGE, left_image_x, top_y + 2 * button_height, 50, 50);
    image(G_GEM_IMAGE, right_image_x, top_y + 2 * button_height, 50, 50);
    image(G_DIAMOND_IMAGE, left_image_x, top_y + 4 * button_height, 50, 50);
    image(G_DIAMOND_IMAGE, right_image_x, top_y + 4 * button_height, 50, 50);
    image(G_ROCK_IMAGE, left_image_x, top_y + 6 * button_height, 50, 50);
    image(G_ROCK_IMAGE, right_image_x, top_y + 6 * button_height, 50, 50);
    
    int top_text_y = top_y + 35;
    textSize(30);
    fill(255);
    text("X 1000", left_text_x, top_text_y);
    text("X 10000", right_text_x, top_text_y);
    text("X 100", left_text_x, top_text_y + 2 * button_height);
    text("X 1000", right_text_x, top_text_y + 2 * button_height);
    text("X 100", left_text_x, top_text_y + 4 * button_height);
    text("X 1000", right_text_x, top_text_y + 4 * button_height);
    text("X 100", left_text_x, top_text_y + 6 * button_height);
    text("X 1000", right_text_x, top_text_y + 6 * button_height);
    
    popStyle();
    
    pushStyle();
    
    fill(0);
    coin_1000.drawit();
    coin_10000.drawit();
    gem_100.drawit();
    gem_1000.drawit();
    diamond_100.drawit();
    diamond_1000.drawit();
    rock_100.drawit();
    rock_1000.drawit();
    back_button.drawit();
    
    popStyle();
  }
  
  // Getter
  CoinButton getBackButton() {
    return back_button;
  }
  
  private CoinButton coin_1000, coin_10000, gem_100, gem_1000, diamond_100, diamond_1000, rock_100, rock_1000;
  private CoinButton back_button;
}
