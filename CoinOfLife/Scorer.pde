public class Scorer {

  public Scorer(int x, int y, int wd, int ht, PImage img) {
    this.x = x;
    this.y = y;
    this.wd = wd;
    this.ht = ht;
    this.score = -1;
    this.max_score = 0;
    this.m_image = img;
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
  
  public void drawit(int c_width, int c_height) {
    fill(0);
    stroke(0);
    int s = score;
    if (s < 0)
      return;
    int[] digits = new int[0];
    while (s >= 0) {
      digits = append(digits, s % 10);
      s = (int)(s / 10);
      if (s == 0)
        break;
    }
    
    image(this.m_image, x, y, c_width * 1.5, c_height * 1.5);
    for (int j = digits.length - 1; j >= 0; j--) {
       image(G_DIGIT_IMAGES[digits[j]], x + (digits.length - j + 1) * wd, y, wd, ht);
    }
  }

  // Private
  private int x;
  private int y;
  private int wd;
  private int ht;
  private int score;
  private int max_score;
  private PImage m_image;
}
