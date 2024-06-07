public class PowerUp implements Asset {
  String type;
  PImage image;
  
  PowerUp(String type) {
    this.type = type; 
    if (type.equals("f")) {
      image = loadImage("fireUp.png");
      image.resize(32,32);
      image.get(16,0,16,16);
      image.resize(50,50);
    } else if (type.equals("b")) {
      image = loadImage("bombUp.png");
      image.resize(32,32);
      image.get(16,0,16,16);
      image.resize(50,50);
    } else if (type.equals("s")) {
      image = loadImage("speedUp.png");
      image.resize(32,32);
      image.get(16,0,16,16);
      image.resize(50,50);
    }
  }
  
  public PImage getImage() {
    return image;
  }
  public String getType() {
    return type;
  }
  
  public float getTime() {return 0;}
  public void tick() {}
  public String getPowerUps() {return "";}
  public boolean hasExit() {return false;}
}
