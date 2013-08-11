public class StoreDrawer {
  
  public StoreDrawer(Player p) {
    player = p;
    
    int button_width = width - player.get_a_width() - player.get_c_width();
    int button_height = player.get_c_height();
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
  }
 
  // drawit
  public void drawit(int a_width, int c_width, int a_height, int c_height) {
    // Setting up background and colors
    background(0);
    stroke(255);
    
    pushStyle();
    
    
    coin_1000.drawit();
    coin_10000.drawit();
    gem_100.drawit();
    gem_1000.drawit();
    diamond_100.drawit();
    diamond_1000.drawit();
    rock_100.drawit();
    rock_1000.drawit();
    
    popStyle();
  }
  
  private Player player;
  private CoinButton coin_1000, coin_10000, gem_100, gem_1000, diamond_100, diamond_1000, rock_100, rock_1000;
}
