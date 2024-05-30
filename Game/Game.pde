Player player;
//ArrayList<Enemy> enemies;
Asset[][] grid;
int rows = 25;
int cols = 17;

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
        if (Math.random() > 0.8) {
          grid[a][b] = new BreakableBlock(a, b);
        }
      }
    }
  }

  //enemies = new ArrayList<>();
}

void draw() {
   background(46,139,0);
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
          grid[bomb.getX()][bomb.getY()] = null;
          player.getBombs().remove(i); 
        }
     }
   }
   for (int r = 0; r < grid.length; r++) {
      for (int c = 0; c < grid[0].length; c++) {
         try {
           image(grid[r][c].getImage(), r * 50, c * 50);
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
  for (int r = x + 1; r < x + str + 1; r++) {
     if (grid[r][y] instanceof BreakableBlock) {
        grid[r][y] = null;
        break;
     }
  }
  for (int r = x - 1; r > x - str - 1; r--) {
     if (grid[r][y] instanceof BreakableBlock) {
        grid[r][y] = null;
        break;
     }
  }
  for (int c = y + 1; c < y + str + 1; c++) {
     if (grid[x][c] instanceof BreakableBlock) {
        grid[x][c] = null;
        break;
     }
  }
  for (int c = y - 1; c > y - str- 1; c--) {
     if (grid[x][c] instanceof BreakableBlock) {
        grid[x][c] = null;
        break;
     }
  }
}
