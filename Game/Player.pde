public class Player implements Asset {
  PImage player;
  float x;
  float y;
  String powerUps;
  int score;
  Asset[][] grid;
  
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
  void setX(int x) {
    this.x = x;
  }
  void setY(int y) {
    this.y = y;
  }
  void updateGrid(Asset[][] grid) {
    this.grid = grid;
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
        y -= 0.05;
        if (grid[(int) x][(int) y] instanceof Block || grid[(int) (x + 0.95)][(int) y] instanceof Block) {
          y += 0.05;
        }
      }
      if (keyCode == DOWN) {
        y += 0.05;
        if (grid[(int) x][(int) (y + 1)] instanceof Block || grid[(int) (x + 0.95)][(int) (y + 1)] instanceof Block) {
          y -= 0.05;
        }
      }
      if (keyCode == LEFT) {
        x -= 0.05;
        if (grid[(int) x][(int) y] instanceof Block || grid[(int) x][(int) (y + 0.95)] instanceof Block) {
           x += 0.05;
        }
      }
      if (keyCode == RIGHT) {
        x += 0.05;
<<<<<<< HEAD
        if (grid[(int) x + 1][(int) y] instanceof Block || grid[(int) x + 1][(int) y + 1] instanceof Block) {
=======
        if (grid[(int) x + 1][(int) y] instanceof Block || grid[(int) x + 1][(int) (y + 0.95)] instanceof Block) {
>>>>>>> b4a15e7bf5b3b4bcade24dff9258439c7ddc5a63
           x -= 0.05;
        }
      }
    }
    
    x = constrain(x, 0, width - player.width);
    y = constrain(y, 0, height - player.height);
  }
  
  boolean up,down,left,right;
  void keyPressed() {
    if (keyCode == UP) {
      up = true;
    }
    if (keyCode == DOWN) {
      down = true;
    }
    if (keyCode == LEFT) {
      left = true;
    }
    if (keyCode == RIGHT) {
      right = true;
    }
  }
  void keyReleased() {
    if (keyCode == UP) {
      up = true;
    }
    if (keyCode == DOWN) {
      down = true;
    }
    if (keyCode == LEFT) {
      left = true;
    }
    if (keyCode == RIGHT) {
      right = true;
    }
  }
    
  
  void display() {
    image(player, x, y);
  }
}
        
