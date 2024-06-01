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
  float getTime() {return 0.0;}
  public void tick() {}
  boolean hasExit() {
    return false;
  }

  
  void dropBomb() {
    if (keyPressed && keyCode == SHIFT && bombs.size() == 0)
    {
       bombs.add(new Bomb((int) (x + 0.5),(int) (y + 0.5)));
    }
    bombJustDropped = true;
  }
  
  void move() {
    if (!onBomb()) {
       bombJustDropped = false; 
    }
    if (up) {
      y -= 0.05;
      if (grid[(int) (x + 0.05)][(int) y] instanceof Barrier || grid[(int) (x + 0.95)][(int) y] instanceof Barrier) {
        y += 0.05;
        if (bombJustDropped) {
          if (!(grid[(int) (x + 0.55)][(int) y] instanceof Block) && !(grid[(int) (x + 0.95)][(int) y] instanceof Block)) {
            y -= 0.05; 
          }
        }
      }
    }
    if (down) {
      y += 0.05;
      if (grid[(int) (x + 0.05)][(int) y + 1] instanceof Barrier || grid[(int) (x + 0.95)][(int) y + 1] instanceof Barrier) {
        y -= 0.05;
        if (bombJustDropped) {
          if (!(grid[(int) (x + 0.05)][(int) y + 1] instanceof Block) && !(grid[(int) (x + 0.95)][(int) y + 1] instanceof Block)) {
            y += 0.05;
          }
        }
      }
    }
    if (left) {
      x -= 0.05;
      if (grid[(int) x][(int) (y + 0.05)] instanceof Barrier || grid[(int) x][(int) (y + 0.95)] instanceof Barrier) {
        x += 0.05;
        if (bombJustDropped) {
          if (!(grid[(int) x][(int) (y + 0.05)] instanceof Block) && !(grid[(int) x][(int) (y + 0.95)] instanceof Block)) {
             x -= 0.05; 
          }
        }
      }
    }
    if (right) {
      x += 0.05;
      if (grid[(int) x + 1][(int) (y + 0.05)] instanceof Barrier || grid[(int) x + 1][(int) (y + 0.95)] instanceof Barrier) {
        x -= 0.05;
        if (bombJustDropped) {
           if (!(grid[(int) x + 1][(int) (y + 0.05)] instanceof Block) && !(grid[(int) x + 1][(int) (y + 0.95)] instanceof Block)) {
              x += 0.05; 
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
        
