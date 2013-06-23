public class Scorer {

  public Scorer(int x, int y, int wd, int ht) {
    this.x = x;
    this.y = y;
    this.wd = wd;
    this.ht = ht;
    score = 0;
    coin_image = loadImage("images/coin.png");
    digit_images = new PImage[10];
    for (int i = 0; i < 10; i++)
      digit_images[i] = loadImage("images/" + i + ".png");
  }

  // Getter
  public int getScore() { 
    return score;
  }
  
  public int getMaxScore() { 
    return max_score;
  }
  
  public void incrementScore() {
    score++;
  }

  public void incrementMaxScore() {
    max_score++;
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
    for (int j = digits.length - 1; j >= 0; j--) {
       image(digit_images[digits[j]], x + (digits.length - j) * wd, y, wd, ht);
     }
  }

  // Private
  private int x;
  private int y;
  private int wd;
  private int ht;
  private int score;
  private int max_score;
  private PImage coin_image;
  private PImage[] digit_images;
}
