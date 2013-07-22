public class CoinButton {

  // Constructor
  public CoinButton(int x, int y, int wd, int ht, String txt) {
    this.x = x;
    this.y = y;
    this.wd = wd;
    this.ht = ht;
    this.txt = txt;
    this.button = new Button(txt, x, y, wd, ht);
    this.button.setImage(G_BUTTON_IMAGE);
    this.button.setImageTint(color(0));
  }

  // drawit
  public void drawit(int a_width, int c_width, int a_height, int c_height) {
    //stroke(255);
    //fill(0);
    //image(G_BUTTON_IMAGE, x, y, wd, ht);
    this.button.display();
    //textSize(20);
    //text(txt, x + 3 * c_width, (int)(y + 1.5 * c_height));
  }
  
  // check if mouse-cliked inside the button
  public boolean mouseClickedInside() {
    return this.button.mouseReleased();
  }
  
  //private
  private int x;
  private int y;
  private int wd;
  private int ht;
  private String txt;
  private Button button;
}

