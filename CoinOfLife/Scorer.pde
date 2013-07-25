public class Scorer {

  public Scorer(int x, int y, int wd, int ht, PImage img) {
    this.x = x;
    this.y = y;
    this.wd = wd;
    this.ht = ht;
    init();
    this.m_image = img;
  }

  public void init() {
    this.score = -1;
    this.max_score = 0;
  }
  
  // Getter
  public int getScore() { 
    return score;
  }
  
  public int getMaxScore() { 
    return max_score;
  }
  
  public void incrementScore(int i) {
    this.score = this.score + i;
  }

  public void incrementMaxScore(int i) {
    this.max_score = this.max_score + i;
  }
 
  public boolean reachedMaxScore() {
    return (this.score >= this.max_score);
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
       image(G_DIGIT_IMAGES[digits[j]], x + (digits.length - j) * wd, y, wd, ht);
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
