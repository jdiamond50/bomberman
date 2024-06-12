public class Block implements Asset, Barrier {
  private PImage blockImage;
  private int x;
  private int y;
  
  public Block(int xcor, int ycor) {
     x = xcor;
     y = ycor;
     blockImage = loadImage("environment.png");
     blockImage.resize(240,125);
     blockImage = blockImage.get(147,30,15,15); //breakable block is (163,46,15,15)
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
  float getTime() {return 0.0;}
  public void tick() {}
  
  void display() {
    image(blockImage, x, y);
  }
  
  boolean hasExit() {return false;}
  String getPowerUps () {return "";}
  String getType() {return "";};
}
