public class GlobalMenu {

  public GlobalMenu(int a_width, int c_width, int a_height, int c_height) {
    this.c_width = c_width;
    this.c_height = c_height;
    int button_width = width - a_width - c_width;
    int button_height = c_width * 2;
    int scorer_x = (int)(width / 2) - 100;
    int coin_scorer_y = (int)(height / 2) - 100;
    int gem_scorer_y = coin_scorer_y + 2 * c_height;
    int diamond_scorer_y = gem_scorer_y + 2 * c_height;
    int rock_scorer_y = diamond_scorer_y + 2 * c_height;
    coin_scorer = new Scorer(scorer_x, coin_scorer_y, (int)(1.5 * c_width), (int)(1.5 * c_height), G_COIN_IMAGE);
    gem_scorer = new Scorer(scorer_x, gem_scorer_y, (int)(1.5 * c_width), (int)(1.5 * c_height), G_GEM_IMAGE);
    diamond_scorer = new Scorer(scorer_x, diamond_scorer_y, (int)(1.5 * c_width), (int)(1.5 * c_height), G_DIAMOND_IMAGE);
    rock_scorer = new Scorer(scorer_x, rock_scorer_y, (int)(1.5 * c_width), (int)(1.5 * c_height), G_ROCK_IMAGE);
    coin_scorer.incrementScore(1);
    gem_scorer.incrementScore(1);
    diamond_scorer.incrementScore(1);
    rock_scorer.incrementScore(1);
    
    continue_button = new CoinButton((int)((width - button_width) / 2), (int)((height) / 2) + 200, button_width, button_height, "Next Level");
  }
  
  public void display(int level) {
    background(0);
    stroke(255);
    pushStyle();
    textSize(100);
    fill(183, 154, 0);
    text("Level " + level, (int)(width /2) - 250, 150);
    popStyle(); 
    coin_scorer.drawit(c_width, c_height);
    gem_scorer.drawit(c_width, c_height);
    diamond_scorer.drawit(c_width, c_height);
    rock_scorer.drawit(c_width, c_height);
    continue_button.drawit();
  }
  
  // Getters
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
  public CoinButton getContinueButton() {
    return continue_button;
  }
  
  private int c_width, c_height;
  
  // Coins, Gems, Diamond
  private int coins, gems, diamonds, rocks;
  
  // Continue Button
  private CoinButton continue_button;
  private Scorer coin_scorer, gem_scorer, diamond_scorer, rock_scorer;
}
