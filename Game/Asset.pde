interface Asset {
   public PImage getImage(); 
   public float getTime();
   public void tick();
   boolean hasExit();
   String getPowerUps();
   String getType();
}
