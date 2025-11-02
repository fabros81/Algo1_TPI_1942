import gifAnimation.*;
GameManager gm;
Gif avionJugadorGIF;


void setup()
{
  size(800, 600);

  rectMode(CENTER);
  imageMode(CENTER);
  gm = new GameManager();
  avionJugadorGIF = new Gif(this, "AvionAliado.gif");
  avionJugadorGIF.play();
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

/*

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
*/
