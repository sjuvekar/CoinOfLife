public class Scorer {

  public Scorer(int x, int y) {
    this.x = x;
    this.y = y;
    score = 0;
    coin_image = loadImage("images/coin.png");
  }

  public void incrementScore() {
    score++;
  }

  public void drawit(int a_width, int c_width, int a_height, int c_height) {
    fill(0);
    stroke(0);
    int s = score;
    int[] digits = new int[0];
    while (s >= 0) {
      digits = append(digits, s % 10);
      s = (int)(s / 10);
      if (s == 0)
        break;
    }
    
    image(coin_image, x, y, c_width * 2, c_height * 2);
    
  }

  // Private
  private int x;
  private int y;
  private int score;
  private PImage coin_image;
}
