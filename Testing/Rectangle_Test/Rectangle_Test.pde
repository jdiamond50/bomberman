PImage player;
int[] playerCoords;
PImage enemy;
int[] enemyCoords;

void setup() {
  size(1000,800);
  player = loadImage("bomberman-sprite.png");
  player.resize(100,0);
  playerCoords = new int[] {500, 400};
  
  enemy = loadImage("red-x.png");
  enemy.resize(100,0);
  enemyCoords = new int[] {300, 300};
  
  frameRate(10000);
}

void draw() {
  background(256, 256, 256);
  if (keyCode == UP) {
    playerCoords[1] -= 7;
  }
  if (keyCode == DOWN) {
    playerCoords[1] += 7;
  }
  if (keyCode == RIGHT) {
    playerCoords[0] += 7;
  }
  if (keyCode == LEFT) {
    playerCoords[0] -= 7;
  }
  image(enemy, enemyCoords[0], enemyCoords[0]);
  image(player, playerCoords[0], playerCoords[1]);
  if (playerCoords[0] <= enemyCoords[0] + enemy.width && playerCoords[0] + player.width >= enemyCoords[0] && 
      playerCoords[1] <= enemyCoords[1] + enemy.height && playerCoords[1] + player.height >= enemyCoords[1]) {
     playerCoords = new int[] {500, 500}; 
  }
  keyCode = 0;
}

void keyPressed() {
  
}
