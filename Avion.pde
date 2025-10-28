abstract class Avion
{
  protected PVector posicion;
  protected float radio;
  protected float velocidad;
  protected boolean isAlive = true;
  protected float hp;
  protected GameManager gm;

  public Avion(GameManager gm,float x, float y,float rad, float vel, float hp){
    this.gm = gm;
    this.posicion = new PVector(x,y);
    this.radio = rad;
    this.velocidad = vel;
    this.hp = hp;
  }
  
  abstract void mover();
  abstract void dibujar();
  abstract void disparar();
  void restarVida(float i){this.hp -= i;}
  void murio(){this.isAlive = false;}
}
