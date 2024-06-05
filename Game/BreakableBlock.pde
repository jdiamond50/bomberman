public class BreakableBlock extends Block {
  private PImage breakableBlock;
  private boolean hasExit;
  private String powerUps;
  
  public BreakableBlock(int xVal, int yVal, boolean hasExit, String powerUps) {
    super(xVal, yVal);
    if (powerUps.equals("")) {
      breakableBlock = loadImage("environment.png");
      breakableBlock.resize(240,125);
      breakableBlock = breakableBlock.get(163,46,15,15); 
      breakableBlock.resize(50,50); 
    } else if (powerUps.equals("f")) {
      breakableBlock = loadImage("fireUp.png");
      breakableBlock.resize(50,50);
    } else if (powerUps.equals("b")) {
      breakableBlock = loadImage("bombUp.png");
      breakableBlock.resize(50,50);
    }
    if (hasExit == true) {
      breakableBlock.resize(30,30); // temporary size change to indicate where it is 
    }
    this.hasExit = hasExit;
    this.powerUps = powerUps;
  }
  
  PImage getImage() {
     return breakableBlock; 
  }
  boolean hasExit() {
    return hasExit; 
  }
}
