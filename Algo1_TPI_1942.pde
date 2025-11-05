import gifAnimation.*;
GameManager gm;
Gif avionJugadorGIF;
PImage corazon;
Gif explode;
PImage enemigoR;

void setup()
{
  size(800, 600);
  frameRate(60);

  rectMode(CENTER);
  imageMode(CENTER);
  gm = new GameManager();
  avionJugadorGIF = new Gif(this, "AvionAliado.gif");
  avionJugadorGIF.play();
  corazon = loadImage("corazon.png");
  explode = new Gif(this, "Explosion.gif");
  enemigoR = loadImage("EnemigoRojo.png");
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
void keyTyped() {
  gm.keyTyped();
}

