public class CoinButton {

  // Constructor
  public CoinButton(int x, int y, int wd, int ht, String txt) {
    this.x = x;
    this.y = y;
    this.wd = wd;
    this.ht = ht;
    this.txt = txt;
    this.button = new Button(txt, x, y, wd, ht);
    this.button.setInactiveImage(G_BUTTON_IMAGE);
    this.button.setActiveImage(G_ACTIVE_BUTTON_IMAGE);
  }

  // drawit
  public void drawit() {
    //stroke(255);
    //fill(0);
    //image(G_BUTTON_IMAGE, x, y, wd, ht);
    pushStyle();
    fill(0);
    this.button.display();
    popStyle();
    //textSize(20);
    //text(txt, x + 3 * c_width, (int)(y + 1.5 * c_height));
  }
  
  // check if mouse-cliked inside the button
  public boolean mouseReleased() {
    return this.button.mouseReleased();
  }
  
  public boolean mousePressed() {
    return this.button.mousePressed();
  }
  
  //private
  private int x;
  private int y;
  private int wd;
  private int ht;
  private String txt;
  private Button button;
}

