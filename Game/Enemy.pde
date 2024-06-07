public class Enemy {
  private PImage enemy;
  private float x;
  private float y;
  private int points;
  private Asset[][] grid;
  private int difficulty;
  private int direction;
  private int moveTime;
  private int time;
  private boolean deadEnd;
  private int deadEndTime;
  
  public Enemy(float x, float y, int diff) {
    enemy = loadImage("enemy1.png");
    enemy.resize(50, 50);
    this.x = x;
    this.y = y;
    difficulty = diff;
    points = 100; //can add higher difficulty enemies with more points later
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
    return enemy;
  }
  int getPoints() {
    return points;
  }
  
  void move() {
    if (deadEnd) {
      deadEndTime++;
      if (deadEndTime >= 90) {
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
      else {
        return;
      }
    }
    
    if (direction == 1) {
      y -= 0.03;
      if (grid[(int) (x + 0.05)][(int) y] instanceof Barrier || grid[(int) (x + 0.95)][(int) y] instanceof Barrier) {
        y += 0.03;
        deadEnd = true;
        
      }
    }
    if (direction == 2) {
      y += 0.03;
      if (grid[(int) (x + 0.05)][(int) y + 1] instanceof Barrier || grid[(int) (x + 0.95)][(int) y + 1] instanceof Barrier) {
        y -= 0.03;
        deadEnd = true;
        
      }
    }
    if (direction == 3) {
      x -= 0.03;
      if (grid[(int) x][(int) (y + 0.05)] instanceof Barrier || grid[(int) x][(int) (y + 0.95)] instanceof Barrier) {
        x += 0.03;
        deadEnd = true;
        
      }
    }
    if (direction == 4) {
      x += 0.03;
      if (grid[(int) x + 1][(int) (y + 0.05)] instanceof Barrier || grid[(int) x + 1][(int) (y + 0.95)] instanceof Barrier) {
        x -= 0.03;
        deadEnd = true;
      }
    }
    x = constrain(x, 0, width - enemy.width);
    y = constrain(y, 0, height - enemy.height);
    
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
    image(enemy, x*50, y*50);
  }
}
    
