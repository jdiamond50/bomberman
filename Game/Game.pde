Player player;
//ArrayList<Enemy> enemies;
//ArrayList<Bomb> bombs;
Asset[][] grid;
int rows = 15;
int cols = 15;

Asset[][] getGrid() {
  return grid;
}

void setup() {
  size(1200,800);
  grid = new Asset[rows][cols];
  player = new Player(5,5);
  grid[5][5] = player;
  grid[10][10] = new Block(10,10);
  grid[10][11] = new Block(10,11);
  grid[8][10] = new Block(8,10);
  grid[8][11] = new Block (8,11);

  //enemies = new ArrayList<>();
  //bombs = new ArrayList<>();
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
