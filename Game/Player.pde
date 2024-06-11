public class Player implements Asset {
  private PImage player;
  private float x;
  private float y;
  private String powerUps;
  private int score;
  private ArrayList<Bomb> bombs;
  private Asset[][] grid;
  private boolean up,down,left,right;
  private boolean bombJustDropped;
  private int bombRadius;
  private int numBombs;
  private float speed;
  
  public Player(float x, float y) {
    this.x = x;
    this.y = y;
    player = loadImage("bomberman.png");
    player.resize(50, 50);
    powerUps = "";
    score = 0;
    bombs = new ArrayList<Bomb>();
    up = down = left = right = false;
    bombJustDropped = false;
    bombRadius = 1;
    numBombs = 1;
    speed = 0.05;
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
  ArrayList<Bomb> getBombs() {
     return bombs; 
  }
  int getScore() {
    return score;
  }
  boolean onBomb() {
     return grid[(int) x][(int) y] instanceof Bomb || grid[(int) x + 1][(int) y] instanceof Bomb || grid[(int) x][(int) y + 1] instanceof Bomb || grid[(int) x + 1][(int) y + 1] instanceof Bomb;
  }
  boolean onExit() {
    return grid[(int) (x + 0.1)][(int) (y + 0.1)] instanceof Exit && grid[(int) (x + 0.9)][(int) (y + 0.1)] instanceof Exit && grid[(int) (x + 0.1)][(int) (y + 0.9)] instanceof Exit && grid[(int) (x + 0.9)][(int) (y + 0.9)] instanceof Exit;
  }
  boolean onPowerUp() {
    return grid[(int) (x + 0.1)][(int) (y + 0.1)] instanceof PowerUp && grid[(int) (x + 0.9)][(int) (y + 0.1)] instanceof PowerUp && grid[(int) (x + 0.1)][(int) (y + 0.9)] instanceof PowerUp && grid[(int) (x + 0.9)][(int) (y + 0.9)] instanceof PowerUp;
  }
  float getTime() {return 0.0;}
  public void tick() {}
  boolean hasExit() {return false;}
  String getType() {return "";}
  String getPowerUps () {
    return powerUps;
  }
  void clearBombs() {
    while (bombs.size() > 0) {
      bombs.remove(0);
    }
  }
  void addPowerUp(String type) {
    powerUps += type;
    //System.out.println("added powerUp: " + type);
    if (type.equals("f")) {
      bombRadius += 2;
    } else if (type.equals("b")) {
      numBombs++;
    } else if (type.equals("s")) {
      speed += 0.02;
    }
  }
  int getBombRadius() {
    return bombRadius;
  }
  int getNumBombs() {
    return numBombs;
  }

  
  void dropBomb() {
    if (keyPressed && keyCode == SHIFT && bombs.size() < numBombs)
    {
      if (grid[(int) (x + 0.5)][(int) (y + 0.5)] instanceof PowerUp || grid[(int) (x + 0.5)][(int) (y + 0.5)] instanceof Exit) {
        return;
      }
      if (!(grid[(int) (x + 0.5)][(int) (y + 0.5)] instanceof Bomb)) {
        bombs.add(new Bomb((int) (x + 0.5),(int) (y + 0.5)));
      }
    }
    bombJustDropped = true;
  }
  
  void move() {
    if (!onBomb()) {
       bombJustDropped = false; 
    }
    if (up) {
      y -= speed;
      if (grid[(int) (x + speed)][(int) y] instanceof Barrier || grid[(int) (x + 1 - speed)][(int) y] instanceof Barrier) {
        y += speed;
        if (bombJustDropped) {
          if (!(grid[(int) (x + speed)][(int) y] instanceof Block) && !(grid[(int) (x + 1 - speed)][(int) y] instanceof Block)) {
            y -= speed; 
          }
        }
      }
    }
    if (down) {
      y += speed;
      if (grid[(int) (x + speed)][(int) y + 1] instanceof Barrier || grid[(int) (x + 1 - speed)][(int) y + 1] instanceof Barrier) {
        y -= speed;
        if (bombJustDropped) {
          if (!(grid[(int) (x + speed)][(int) y + 1] instanceof Block) && !(grid[(int) (x + 1 - speed)][(int) y + 1] instanceof Block)) {
            y += speed;
          }
        }
      }
    }
    if (left) {
      x -= speed;
      if (grid[(int) x][(int) (y + speed)] instanceof Barrier || grid[(int) x][(int) (y + 1 - speed)] instanceof Barrier) {
        x += speed;
        if (bombJustDropped) {
          if (!(grid[(int) x][(int) (y + speed)] instanceof Block) && !(grid[(int) x][(int) (y + 1 - speed)] instanceof Block)) {
             x -= speed; 
          }
        }
      }
    }
    if (right) {
      x += speed;
      if (grid[(int) x + 1][(int) (y + speed)] instanceof Barrier || grid[(int) x + 1][(int) (y + 1 - speed)] instanceof Barrier) {
        x -= speed;
        if (bombJustDropped) {
           if (!(grid[(int) x + 1][(int) (y + speed)] instanceof Block) && !(grid[(int) x + 1][(int) (y + 1 - speed)] instanceof Block)) {
              x += speed; 
           }
        }
      }
    }
    
    x = constrain(x, 0, width - player.width);
    y = constrain(y, 0, height - player.height);
  }
  
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
      up = false;
    }
    if (keyCode == DOWN) {
      down = false;
    }
    if (keyCode == LEFT) {
      left = false;
    }
    if (keyCode == RIGHT) {
      right = false;
    }
  }
    
  
  void display() {
    image(player, x, y);
  }
}
        
