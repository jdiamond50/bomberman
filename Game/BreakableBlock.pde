public class BreakableBlock extends Block {
  private PImage breakableBlock;
  private boolean containsExit;
  
  public BreakableBlock(int xVal, int yVal, boolean containsExit) {
    super(xVal, yVal);
    breakableBlock = loadImage("environment.png");
    breakableBlock.resize(240,125);
    breakableBlock = breakableBlock.get(163,46,15,15); 
    breakableBlock.resize(50,50);
    if (containsExit == true) {
      breakableBlock.resize(30,30); // temporary size change to indicate where it is 
    }
    this.containsExit = containsExit;
  }
  
  PImage getImage() {
     return breakableBlock; 
  }
}
