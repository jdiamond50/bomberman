public class BreakableBlock extends Block {
  PImage breakableBlock;
  
  public BreakableBlock(int xVal, int yVal) {
    super(xVal, yVal);
    breakableBlock = loadImage("environment.png");
    breakableBlock.resize(240,125);
    breakableBlock = breakableBlock.get(163,46,15,15); 
    breakableBlock.resize(50,50);
  }
  
  PImage getImage() {
     return breakableBlock; 
  }
  
  void display() {
    image(breakableBlock, x, y);
  }
}
