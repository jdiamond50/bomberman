Player player;
ArrayList<Enemy> enemies;
Asset[][] grid;
int rows = 25;
int cols = 17;
float blockDensity = 0.9;
int pixelsPerSquare = 50;
int score = 0;
int timeLeft = 200;
int time = 0;
boolean gameOver = false;
PImage winScreen;
PImage loseScreen;


void setup() {
  size(1250,850);
  grid = new Asset[rows][cols];
  player = new Player(5,5);
  textSize(32);
  winScreen = loadImage("win.jpg");
  loseScreen = loadImage("lose.PNG");
  // fills border with blocks
  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[0].length; j++) {
      if (i == 0 || i == rows -1 || j == 0 || j == cols -1) {
        grid[i][j] = new Block(i, j);
      }
    }
  }
  // fills middle with blocks
  for (int x = 1; x < grid.length-2; x++) {
    for (int y = 1; y < grid[0].length-1; y++) {
      if (x % 2 == 0 && y % 2 == 0) {
        grid[x][y] = new Block(x, y);
      }
    }
  }
  // fills with breakable blocks
  for (int a = 1; a < grid.length-1; a++) {
    for (int b = 1; b < grid[0].length-1; b++) {
      if (!(grid[a][b] instanceof Block)) {
        if (Math.random() > blockDensity) {
          grid[a][b] = new BreakableBlock(a, b, false, "");
        }
      }
    }
  }
  // creates enemies
  enemies = new ArrayList<>();
  for (int i = 0; i < 5; i++) {
    int randX = (int) (Math.random() * 22 +1);
    int randY = (int) (Math.random() * 14 + 1);
    while (grid[randX][randY] instanceof Block || grid[randX][randY] instanceof BreakableBlock) {
      randX = (int) (Math.random() * 22 +1);
      randY = (int) (Math.random() * 14 + 1);
    }
    enemies.add(new Enemy(randX, randY, 1));
    if (i % 2 == 0) {
      enemies.add(new Enemy(randX, randY, 2));
    }
  }
  ArrayList<int[]> usedCoords = new ArrayList<>();
  // places exit in one breakable block
  boolean blockPlaced = false;
  while (!blockPlaced) {
    int r = (int) (Math.random() * rows);
    int c = (int) (Math.random() * cols);
    if (grid[r][c] instanceof BreakableBlock) {
      grid[r][c] = new BreakableBlock(r, c, true, "");
      System.out.println("eixt placed at (" + r + ", " + c + ")");
      int[] coords = {r, c};
      usedCoords.add(coords);
      blockPlaced = true;
    }
  }
  // places fireUp powerup in one breakable block
  System.out.println("after exit: " + usedCoords.toString());
  blockPlaced = false;
  while (!blockPlaced) {
    int r = (int) (Math.random() * rows);
    int c = (int) (Math.random() * cols);
    int[] coords = {r, c};
    if (grid[r][c] instanceof BreakableBlock) {
      for (int i = 0; i < usedCoords.size(); i++) {
        if (coords.equals(usedCoords.get(i))) {
          continue; 
        }
      }
      grid[r][c] = new BreakableBlock(r, c, false, "f");
      System.out.println("fireUp placed at (" + r + ", " + c + ")");
      usedCoords.add(coords);
      blockPlaced = true;
    }
  }
  // places bombUp powerup in one breakable block
  System.out.println("after fireUp: " + usedCoords.toString());
  blockPlaced = false;
  while (!blockPlaced) {
    int r = (int) (Math.random() * rows);
    int c = (int) (Math.random() * cols);
    int[] coords = {r, c};
    if (grid[r][c] instanceof BreakableBlock) {
      for (int i = 0; i < usedCoords.size(); i++) {
        if (coords.equals(usedCoords.get(i))) {
          continue; 
        }
      }
      grid[r][c] = new BreakableBlock(r, c, false, "b");
      System.out.println("bombUp placed at (" + r + ", " + c + ")");
      usedCoords.add(coords);
      blockPlaced = true;
    }
  }
  // places speedUp powerup in one breakable block
  blockPlaced = false;
  System.out.println("after bombUp: " + usedCoords.toString());
  while (!blockPlaced) {
    int r = (int) (Math.random() * rows);
    int c = (int) (Math.random() * cols);
    int[] coords = {r, c};
    if (grid[r][c] instanceof BreakableBlock) {
      for (int i = 0; i < usedCoords.size(); i++) {
        if (coords.equals(usedCoords.get(i))) {
          continue; 
        }
      }
      grid[r][c] = new BreakableBlock(r, c, false, "s");
      System.out.println("speedUp placed at (" + r + ", " + c + ")");
      usedCoords.add(coords);
      blockPlaced = true;
    }
  }
}

void draw() {
   background(0,126,41);
   player.updateGrid(grid);
   player.move();
   player.dropBomb();
   if (player.onExit() && enemies.size() == 0) {
      background(0);
      image(winScreen, 0, 0, width, height);
      noLoop();
      return;  
   }
   if (onExplosion(player)) {
     background(0);
     image(loseScreen, 0, 0, width, height);
     noLoop();
     return;
   }
   if (timeLeft <= 0) {
     background(0);
     image(loseScreen, 0, 0, width, height);
     noLoop();
     return;
   }
   if (player.onPowerUp()) {
     player.addPowerUp(grid[(int) (player.getX() + 0.5)][(int) (player.getY() + 0.5)].getType());
     grid[(int) (player.getX() + 0.5)][(int) (player.getY() + 0.5)] = null;
   }
   for (int i = 0; i < player.getBombs().size(); i++) {
     Bomb bomb = player.getBombs().get(i);
     if (bomb.getTime() > 0) {
        //image(bomb.getImage(), bomb.getX() * 50, bomb.getY() * 50);
        grid[bomb.getX()][bomb.getY()] = bomb;
        bomb.tick();
        if (bomb.getTime() <= 0) {
          player.getBombs().remove(i); 
          detonate(bomb.getX(), bomb.getY(), player.getBombRadius());
        }
     }
   }
   for (int r = 0; r < grid.length; r++) {
      for (int c = 0; c < grid[0].length; c++) {
         try {
           image(grid[r][c].getImage(), r * pixelsPerSquare, c * pixelsPerSquare);
           if (grid[r][c] instanceof Explosion) {
             try {
               grid[r][c].tick();
               if (grid[r][c].getTime() <= 0) {
                  grid[r][c] = null; 
               }
             } catch (Exception e) {
               
             }
           }
         } catch (Exception e) {
           
         }
      }
   }
   for (int i = 0; i < enemies.size(); i++) {
     Enemy enemy = enemies.get(i);
     enemy.display();
     enemy.updateGrid(grid);
     enemy.move();
     if (playerOnEnemy(player, enemy)) {
        background(0);
       image(loseScreen, 0, 0, width, height);
       noLoop(); 
       return;
     }
     if (onExplosion(enemy)) {
       enemies.remove(enemy); 
       i--;
       score += enemy.getPoints();
     }
   }
   image(player.getImage(), player.getX() * pixelsPerSquare, player.getY() * pixelsPerSquare); 
   fill(0);
   text("Score: " + score, 100, 35);
   text("Time Left: " + timeLeft, 350, 35);
   time++;
   if (time >= 60) {
     timeLeft--;
     time = 0;
  }
}

boolean playerOnEnemy(Player p, Enemy e) {
  return (p.getX() + 0.1 < (e.getX() + 0.9) && (p.getX() + 0.9) > e.getX() + 0.1) && (p.getY() + 0.1 < (e.getY() + 0.9) && (p.getY() + 0.9) > e.getY() + 0.1);
}
boolean onExplosion(Enemy e) {
  return (grid[(int) (e.getX() + 0.1)][(int) (e.getY() + 0.1)] instanceof Explosion) || (grid[(int) (e.getX() + 0.1)][(int) (e.getY() + 0.9)] instanceof Explosion) || (grid[(int) (e.getX() + 0.9)][(int) (e.getY() + 0.1)] instanceof Explosion) || (grid[(int) (e.getX() + 0.9)][(int) (e.getY() + 0.9)] instanceof Explosion);
}
boolean onExplosion(Player e) {
  return (grid[(int) (e.getX() + 0.1)][(int) (e.getY() + 0.1)] instanceof Explosion) || (grid[(int) (e.getX() + 0.1)][(int) (e.getY() + 0.9)] instanceof Explosion) || (grid[(int) (e.getX() + 0.9)][(int) (e.getY() + 0.1)] instanceof Explosion) || (grid[(int) (e.getX() + 0.9)][(int) (e.getY() + 0.9)] instanceof Explosion);
}

void keyPressed() {
  player.keyPressed();
}
void keyReleased() {
  player.keyReleased();
}

void detonate(int x, int y, int strength ) {
  grid[x][y] = new Explosion("mid");
  for (int r = x + 1; r < x + strength + 1; r++) {
     if (grid[r][y] instanceof BreakableBlock) {
        if (grid[r][y].hasExit()) {
          grid[r][y] = new Exit(r, y);
          image(grid[r][y].getImage(), r * pixelsPerSquare, y * pixelsPerSquare);
        } else if (grid[r][y].getPowerUps().length() > 0) {
          grid[r][y] = new PowerUp(grid[r][y].getPowerUps());
        } else {
          grid[r][y] = new Explosion("rightEnd");
        }
        break;
     }
     if (grid[r][y] instanceof Block) {
        break; 
     }
     if (grid[r][y] instanceof Bomb) {
       detonate(r, y, player.getBombRadius());
       System.out.println("detonated bomb");
       player.clearBombs();
     }
     if (r == x + strength) {
       grid[r][y] = new Explosion("rightEnd");
     } else {
       grid[r][y] = new Explosion("horizontal");
     }
  }
  for (int r = x - 1; r > x - strength - 1; r--) {
     if (grid[r][y] instanceof BreakableBlock) {
       if (grid[r][y].hasExit()) {
          grid[r][y] = new Exit(r, y);
          image(grid[r][y].getImage(), r * pixelsPerSquare, y * pixelsPerSquare);
        } else if (grid[r][y].getPowerUps().length() > 0) {
          grid[r][y] = new PowerUp(grid[r][y].getPowerUps());
        } else {
          grid[r][y] = new Explosion("leftEnd");
        }
        break;
     }
     if (grid[r][y] instanceof Block) {
        break; 
     }
     if (grid[r][y] instanceof Bomb) {
       detonate(r, y, player.getBombRadius());
       System.out.println("detonated bomb");
       player.clearBombs();
     }
     if (r == x - strength) {
        grid[r][y] = new Explosion("leftEnd");
     } else {
       grid[r][y] = new Explosion("horizontal");
     }
  }
  for (int c = y + 1; c < y + strength + 1; c++) {
     if (grid[x][c] instanceof BreakableBlock) {
       if (grid[x][c].hasExit()) {
          grid[x][c] = new Exit(x, c);
          image(grid[x][c].getImage(), x * pixelsPerSquare, c * pixelsPerSquare);
        } else if (grid[x][c].getPowerUps().length() > 0) {
          grid[x][c] = new PowerUp(grid[x][c].getPowerUps());
        } else {
          grid[x][c] = new Explosion("bottomEnd");
        }
        break;
     }
     if (grid[x][c] instanceof Block) {
        break;
     }
     if (grid[x][c] instanceof Bomb) {
       detonate(x, c, player.getBombRadius());
       System.out.println("detonated bomb");
       player.clearBombs();
     }
     if (c == y + strength) {
        grid[x][c] = new Explosion("bottomEnd"); 
     } else {
       grid[x][c] = new Explosion("vertical");
     }
  }
  for (int c = y - 1; c > y - strength- 1; c--) {
     if (grid[x][c] instanceof BreakableBlock) {
        if (grid[x][c].hasExit()) {
          grid[x][c] = new Exit(x, c);
          image(grid[x][c].getImage(), x * pixelsPerSquare, c * pixelsPerSquare);
        } else if (grid[x][c].getPowerUps().length() > 0) {
          grid[x][c] = new PowerUp(grid[x][c].getPowerUps());
        } else {
          grid[x][c] = new Explosion("topEnd");
        }
        break;
     }
     if (grid[x][c] instanceof Block) {
        break;
     }
     if (grid[x][c] instanceof Bomb) {
       detonate(x, c, player.getBombRadius());
       System.out.println("detonated bomb");
       player.clearBombs();
     }
     if (c == y - strength) {
        grid[x][c] = new Explosion("topEnd"); 
     } else {
       grid[x][c] = new Explosion("vertical");
     }
  }
}
