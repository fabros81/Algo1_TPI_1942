import gifAnimation.*;

private GameManager gm;
Gif avionJugadorGIF;
PImage corazon;
PImage boss;
Gif explode;
PImage enemigoR;
PImage enemigoV;
PImage fondoJuego;
PGraphics fondoBuffer;

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
  enemigoV = loadImage("EnemigoVerde.png");
  boss = loadImage("Boss_Green.png");
  fondoJuego = loadImage("fondo_sin_alpha.png");
  fondoBuffer = createGraphics(width, height);
  fondoBuffer.beginDraw();
  fondoBuffer.imageMode(CENTER);
  fondoBuffer.image(fondoJuego, width/2, height/2);
  fondoBuffer.endDraw();
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

