Player player;
//ArrayList<Enemy> enemies;
//ArrayList<Bomb> bombs;
Object[][] grid;
int rows = 400;
int cols = 400;

void setup() {
  size(1200,800);
  grid = new Object[rows][cols];
  player = new Player(100, 100);
  grid[(int) player.getX()][(int) player.getY()] = player;

  //enemies = new ArrayList<>();
  //bombs = new ArrayList<>();
}

void draw() {
   background(46,139,0);
   player.move();
   player.draw();
}
