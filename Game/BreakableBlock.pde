public class BreakableBlock extends Block {
  private PImage breakableBlock;
  private boolean hasExit;
  private String powerUps;
  
  public BreakableBlock(int xVal, int yVal, boolean hasExit, String powerUps) {
    super(xVal, yVal);
    breakableBlock = loadImage("environment.png");
    breakableBlock.resize(240,125);
    breakableBlock = breakableBlock.get(163,46,15,15); 
    breakableBlock.resize(50,50); 
    this.hasExit = hasExit;
    this.powerUps = powerUps;
  }
  
  PImage getImage() {
     return breakableBlock; 
  }
  boolean hasExit() {
    return hasExit; 
  }
  String getPowerUps() {
    return powerUps; 
  }
}
