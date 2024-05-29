public class Bomb implements Asset, Barrier {
  PImage bombImage;
  int x;
  int y;
  float timeLeft;
  
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
}
