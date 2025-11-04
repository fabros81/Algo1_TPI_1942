import gifAnimation.*;
GameManager gm;
Gif avionJugadorGIF;
PImage corazon;

void setup()
{
  size(800, 600);

  rectMode(CENTER);
  imageMode(CENTER);
  gm = new GameManager();
  avionJugadorGIF = new Gif(this, "AvionAliado.gif");
  avionJugadorGIF.play();
  corazon = loadImage("corazon.png");
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
