public class Block implements Asset {
  PImage blockImage;
  int x;
  int y;
  
  public Block(int xcor, int ycor) {
     x = xcor;
     y = ycor;
     blockImage = loadImage("environment.png");
     blockImage.resize(240,125);
     blockImage = blockImage.get(163,46,15,15);
     blockImage.resize(50,50);
  }
  
  int getX() {
     return x; 
  }
  int getY() {
     return y; 
  }
  PImage getImage() {
     return blockImage; 
  }
  
  void display() {
    image(blockImage, x, y);
  }
}
