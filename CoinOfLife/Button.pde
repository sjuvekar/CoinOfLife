public class Button {

  // Constructor
  public Button(int x, int y, int wd, int ht, String txt) {
    this.x = x;
    this.y = y;
    this.wd = wd;
    this.ht = ht;
    this.txt = txt;
    button_image = loadImage("images/button.png");
  }

  // drawit
  public void drawit(int a_width, int c_width, int a_height, int c_height) {
    stroke(255);
    fill(0);
    image(button_image, x, y, wd, ht);
    textSize(20);
    text(txt, x + 3 * c_width, (int)(y + 1.5 * c_height));
  }
  
  // check if mouse-cliked inside the button
  public boolean mouseClickedInside() {
    return (mouseX >= x && mouseX <= x + wd && mouseY >= y && mouseY <= y + ht);
  }
  
  //private
  private int x;
  private int y;
  private int wd;
  private int ht;
  private String txt;
  private PImage button_image;
}

