Player player;
//ArrayList<Enemy> enemies;
Asset[][] grid;
int rows = 25;
int cols = 17;
float blockDensity = 0.8;

void setup() {
  size(1250,850);
  grid = new Asset[rows][cols];
  player = new Player(5,5);
  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[0].length; j++) {
      if (i == 0 || i == rows -1 || j == 0 || j == cols -1) {
        grid[i][j] = new Block(i, j);
      }
    }
  }
  for (int x = 1; x < grid.length-2; x++) {
    for (int y = 1; y < grid[0].length-1; y++) {
      if (x % 2 == 0 && y % 2 == 0) {
        grid[x][y] = new Block(x, y);
      }
    }
  }
  for (int a = 1; a < grid.length-1; a++) {
    for (int b = 1; b < grid[0].length-1; b++) {
      if (!(grid[a][b] instanceof Block)) {
        if (Math.random() > blockDensity) {
          grid[a][b] = new BreakableBlock(a, b);
        }
      }
    }
  }

  //enemies = new ArrayList<>();
}

void draw() {
   background(0,126,41);
   player.updateGrid(grid);
   player.move();
   player.dropBomb();
   image(player.getImage(), player.getX() * 50, player.getY() * 50); 
   for (int i = 0; i < player.getBombs().size(); i++) {
     Bomb bomb = player.getBombs().get(i);
     if (bomb.getTime() > 0) {
        //image(bomb.getImage(), bomb.getX() * 50, bomb.getY() * 50);
        grid[bomb.getX()][bomb.getY()] = bomb;
        bomb.tick();
        if (bomb.getTime() <= 0) {
          detonate(bomb.getX(), bomb.getY(), 1);
          player.getBombs().remove(i); 
        }
     }
   }
   for (int r = 0; r < grid.length; r++) {
      for (int c = 0; c < grid[0].length; c++) {
         try {
           image(grid[r][c].getImage(), r * 50, c * 50);
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
}

void keyPressed() {
  player.keyPressed();
}
void keyReleased() {
  player.keyReleased();
}

void detonate(int x, int y, int str ) {
  grid[x][y] = new Explosion("mid");
  for (int r = x + 1; r < x + str + 1; r++) {
     if (grid[r][y] instanceof BreakableBlock) {
        grid[r][y] = new Explosion("rightEnd");
        break;
     }
     if (grid[r][y] instanceof Block) {
        break; 
     }
     if (r == x + str) {
       grid[r][y] = new Explosion("rightEnd");
     } else {
       grid[r][y] = new Explosion("horizontal");
     }
  }
  for (int r = x - 1; r > x - str - 1; r--) {
     if (grid[r][y] instanceof BreakableBlock) {
        grid[r][y] = new Explosion("leftEnd");
        break;
     }
     if (grid[r][y] instanceof Block) {
        break; 
     }
     if (r == x - str) {
        grid[r][y] = new Explosion("leftEnd");
     } else {
       grid[r][y] = new Explosion("horizontal");
     }
  }
  for (int c = y + 1; c < y + str + 1; c++) {
     if (grid[x][c] instanceof BreakableBlock) {
        grid[x][c] = new Explosion("bottomEnd");
        break;
     }
     if (grid[x][c] instanceof Block) {
        break;
     }
     if (c == y + str) {
        grid[x][c] = new Explosion("bottomEnd"); 
     } else {
       grid[x][c] = new Explosion("vertical");
     }
  }
  for (int c = y - 1; c > y - str- 1; c--) {
     if (grid[x][c] instanceof BreakableBlock) {
        grid[x][c] = new Explosion("topEnd");
        break;
     }
     if (grid[x][c] instanceof Block) {
        break;
     }
     if (c == y - str) {
        grid[x][c] = new Explosion("topEnd"); 
     } else {
       grid[x][c] = new Explosion("vertical");
     }
  }
}
