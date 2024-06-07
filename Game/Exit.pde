public class Exit implements Asset {
  int x;
  int y;
  PImage exitImage;
  
  public Exit(int x, int y) {
     exitImage = loadImage("environment2.png");
     exitImage.resize(256,240);
     exitImage = exitImage.get(16,192,16,16);
     exitImage.resize(50,50);
     this.x = x;
     this.y = y;
  }
  
  public PImage getImage() {
    return exitImage; 
  }
  public float getTime() {return 0.0;}
  public void tick() {}
  boolean hasExit() {return false;}
  String getPowerUps () {return "";}
  String getType() {return "";}
}
