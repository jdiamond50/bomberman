Player player;
//ArrayList<Enemy> enemies;
Asset[][] grid;
int rows = 24;
int cols = 16;

void setup() {
  size(1200,800);
  grid = new Asset[rows][cols];
  grid[5][5] = player;
  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[0].length; j++) {
      if (i == 0 || i == rows -1 || j == 0 || j == cols -1) {
        grid[i][j] = new Block(i, j);
      }
    }
  }
  grid[9][10] = new BreakableBlock(9, 10);

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
