Player player;
//ArrayList<Enemy> enemies;
Asset[][] grid;
int rows = 15;
int cols = 15;

void setup() {
  size(1200,800);
  grid = new Asset[rows][cols];
  player = new Player(5,5);
  grid[10][10] = new Block(10,10);
  grid[10][11] = new Block(10,11);
  grid[8][10] = new Block(8,10);

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
