Player player;
//ArrayList<Enemy> enemies;
ArrayList<Bomb> bombs;
Asset[][] grid;
int rows = 24;
int cols = 16;

Asset[][] getGrid() {
  return grid;
}

void setup() {
  size(1200,800);
  grid = new Asset[rows][cols];
  player = new Player(5,5);
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
  bombs = new ArrayList<>(); 
  bombs.add(new Bomb(8,11));
  
}

void draw() {
   background(46,139,0);
   player.updateGrid(grid);
   player.move();
   for (int r = 0; r < grid.length; r++) {
      for (int c = 0; c < grid[0].length; c++) {
         try {
             if (grid[r][c].equals(player)) {
                image(player.getImage(), player.getX() * 50, player.getY() * 50); 
             } else {
               image(grid[r][c].getImage(), r * 50, c * 50);
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
