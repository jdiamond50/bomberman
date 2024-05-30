public class Explosion implements Asset {
  private PImage explosionImage;
  private float timeLeft;
  
  Explosion(String type) {
    explosionImage = loadImage("sprites.png");
    timeLeft = 0.5;
    if (type.equals("mid")) {
       explosionImage = explosionImage.get(379,512,16,16);
    } else if (type.equals("left")) {
       explosionImage = explosionImage.get(311,478,16,16);
    } else if (type.equals("right")) {
      explosionImage = explosionImage.get(294,546,16,16);  
    } else if (type.equals("top")) {
      explosionImage = explosionImage.get(379,495,16,16);
    } else if (type.equals("bottom")) {
      explosionImage = explosionImage.get(379,546,16,16); 
    }
    explosionImage.resize(50,50);
  }
  
  PImage getImage() {
    return explosionImage;
  }
  float getTime() {
    return timeLeft;
  }
  
  void tick() {
    timeLeft -= 0.015;
  }
}
