public class Player {
  PImage player;
  float x;
  float y;
  String powerUps;
  int score;
  
  public Player(float x, float y) {
    this.x = x;
    this.y = y;
    player = loadImage("bomberman.png");
    player.resize(50, 50);
    powerUps = "";
    score = 0;
  }
  
  float getX() {
    return x;
  }
  
  float getY() {
    return y;
  }
  
  PImage getImage() {
    return player;
  }
  
  int getScore() {
    return score;
  }
  
  void move() {
    if (keyPressed) {
      if (keyCode == UP) {
        y -= 5;
      }
      if (keyCode == DOWN) {
        y += 5;
      }
      if (keyCode == LEFT) {
        x -= 5;
      }
      if (keyCode == RIGHT) {
        x += 5;
      }
    }
    
    x = constrain(x, 0, width - player.width);
    y = constrain(y, 0, height - player.height);
  }
  
  void draw() {
    image(player, x, y);
  }
}
        
