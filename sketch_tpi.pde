GameManager gm;



void setup()
{
  size(800, 600);
  
  rectMode(CENTER);
  gm = new GameManager();
}

void draw()
{
  background(0);
  gm.dibujar();
  gm.actualizar();
}

void keyPressed()
{
  gm.keyPressed();
}
void keyReleased() {
  gm.keyReleased();
}
