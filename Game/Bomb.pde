public class Bomb implements Asset, Barrier {
  private PImage bombImage;
  private int x;
  private int y;
  private float timeLeft;
  
  Bomb(int x, int y) {
     this.x = x;
     this.y = y;
     timeLeft = 3;
     bombImage = loadImage("bomb.png");
     bombImage.resize(50,50);
  }
  
  PImage getImage() {
     return bombImage; 
  }
  float getTime() {
     return timeLeft; 
  }
  void tick() {
    timeLeft -= 0.015;
  }
  int getX() {
    return x;
  }
  int getY() {
    return y; 
  }
  boolean hasExit() {
    return false;
  }
  String getPowerUps () {return "";}
  String getType() {return "";}
}
