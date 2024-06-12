public class Enemy {
  private PImage image;
  private float x;
  private float y;
  private float speed;
  private int points;
  private Asset[][] grid;
  private int direction;
  private int moveTime;
  private int time;
  private boolean deadEnd;
  private int deadEndTime;
  private int difficulty;
  
  public Enemy(float x, float y, int diff) {
    this.x = x;
    this.y = y;
    difficulty = diff;
    if (difficulty == 1) {
      points = 100; 
      speed = 0.03;
      image = loadImage("enemy1.png");
    } else if (difficulty == 2) {
      points = 400;
      speed = 0.06;
      image = loadImage("enemy2.png");
    }
    image.resize(50, 50);
    direction = 1;
    moveTime = 0;
    time = 0;
    deadEnd = false;
    deadEndTime = 0;
  }
  
  float getX() {
    return x;
  }
  float getY() {
    return y;
  }
  int getDiff() {
    return difficulty;
  }
  void setX(int x) {
    this.x = x;
  }
  void setY(int y) {
    this.y = y;
  }
  void setDiff(int diff) {
    this.difficulty = diff;
  }
  void updateGrid(Asset[][] grid) {
    this.grid = grid;
  }
  PImage getImage() {
    return image;
  }
  int getPoints() {
    return points;
  }
  
  void move() {
    if (deadEnd) {
      deadEndTime++;
      if (deadEndTime >= 75) {
        deadEnd = false;
        deadEndTime = 0;
        while (true) {
          direction = (int) (Math.random() * 4 + 1);
          if (direction == 1 && !(grid[(int) (x + 0.05)][(int) y - 1] instanceof Barrier) && !(grid[(int) (x + 0.95)][(int) y - 1] instanceof Barrier)) {
            break;
          } else if (direction == 2 && !(grid[(int) (x + 0.05)][(int) y + 1] instanceof Barrier) && !(grid[(int) (x + 0.95)][(int) y + 1] instanceof Barrier)) {
            break;
          } else if (direction == 3 && !(grid[(int) x - 1][(int) (y + 0.05)] instanceof Barrier) && !(grid[(int) x - 1][(int) (y + 0.95)] instanceof Barrier)) {
            break;
          } else if (direction == 4 && !(grid[(int) x + 1][(int) (y + 0.05)] instanceof Barrier) && !(grid[(int) x + 1][(int) (y + 0.95)] instanceof Barrier)) {
            break;
          }
        }
      }
    }
    
    if (direction == 1) {
      y -= speed;
      if (grid[(int) (x + 0.05)][(int) y] instanceof Barrier || grid[(int) (x + 0.95)][(int) y] instanceof Barrier) {
        y += speed;
        deadEnd = true;
        
      }
    }
    if (direction == 2) {
      y += speed;
      if (grid[(int) (x + 0.05)][(int) y + 1] instanceof Barrier || grid[(int) (x + 0.95)][(int) y + 1] instanceof Barrier) {
        y -= speed;
        deadEnd = true;
        
      }
    }
    if (direction == 3) {
      x -= speed;
      if (grid[(int) x][(int) (y + 0.05)] instanceof Barrier || grid[(int) x][(int) (y + 0.95)] instanceof Barrier) {
        x += speed;
        deadEnd = true;
        
      }
    }
    if (direction == 4) {
      x += speed;
      if (grid[(int) x + 1][(int) (y + 0.05)] instanceof Barrier || grid[(int) x + 1][(int) (y + 0.95)] instanceof Barrier) {
        x -= speed;
        deadEnd = true;
      }
    }
    x = constrain(x, 0, width - image.width);
    y = constrain(y, 0, height - image.height);
    
    time++;
    if (time >= moveTime) {
      moveTime = (int) (Math.random()* 181 + 240);
      while (true) {
          direction = (int) (Math.random() * 4 + 1);
          if (direction == 1 && !(grid[(int) (x + 0.05)][(int) y - 1] instanceof Barrier) && !(grid[(int) (x + 0.95)][(int) y - 1] instanceof Barrier)) {
            break;
          } else if (direction == 2 && !(grid[(int) (x + 0.05)][(int) y + 1] instanceof Barrier) && !(grid[(int) (x + 0.95)][(int) y + 1] instanceof Barrier)) {
            break;
          } else if (direction == 3 && !(grid[(int) x - 1][(int) (y + 0.05)] instanceof Barrier) && !(grid[(int) x - 1][(int) (y + 0.95)] instanceof Barrier)) {
            break;
          } else if (direction == 4 && !(grid[(int) x + 1][(int) (y + 0.05)] instanceof Barrier) && !(grid[(int) x + 1][(int) (y + 0.95)] instanceof Barrier)) {
            break;
          }
      }
      time = 0;
    }
  }
  
  void display() {
    image(image, x*50, y*50);
  }
}
    
