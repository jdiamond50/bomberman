class Block {
  PImage blockImage;
  int x;
  int y;
  
  public Block(int xcor, int ycor) {
     x = xcor;
     y = ycor;
     blockImage = loadImage("sprites.png").get(311, 461, 16, 16);
  }
}
