public class Enemy implements Asset {
  PImage enemy;
  float x;
  float y;
  int points;
  int difficulty; 
  
  public Enemy(float x, float y, int diff) {
    //get image enemy = loadImage( 
    this.x = x;
    this.y = y;
    difficulty = diff;
    points = 100; //can add higher difficulty enemies with more points later
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
    return enemy;
  }
  int getPoints() {
    return points;
  }
  
  void move() {
    
  }
    
