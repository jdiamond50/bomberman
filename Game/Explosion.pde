public class Explosion implements Asset {
  private PImage explosionImage;
  private float timeLeft;
  
  Explosion(String type) {
    explosionImage = loadImage("sprites.png");
    timeLeft = 0.5;
    if (type.equals("mid")) {
       explosionImage = explosionImage.get(379,512,16,16);
    } else if (type.equals("leftEnd")) {
       explosionImage = explosionImage.get(266,323,16,16);
    } else if (type.equals("rightEnd")) {
      explosionImage = explosionImage.get(232,374,16,16);  
    } else if (type.equals("topEnd")) {
      explosionImage = explosionImage.get(379,495,16,16);
    } else if (type.equals("bottomEnd")) {
      explosionImage = explosionImage.get(379,546,16,16); 
    } else if (type.equals("vertical")) {
      explosionImage = explosionImage.get(317,374,16,16);
    } else if (type.equals("horizontal")) {
      explosionImage = explosionImage.get(215,357,16,16);  
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
  boolean hasExit() {
    return false;
  }
  String getPowerUps () {return "";}
  String getType() {return "";}
}
