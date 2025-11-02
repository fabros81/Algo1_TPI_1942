abstract class Avion
{
  protected PVector posicion;
  protected float radio;
  protected float velocidad;
  protected boolean isAlive = true;
  protected float hp;
  protected GameManager gm;

  public Avion(){}
  public Avion(GameManager gm,float x, float y,float rad, float vel, float hp){
    this.gm = gm;
    this.posicion = new PVector(x,y);
    this.radio = rad;
    this.velocidad = vel;
    this.hp = hp;
  }
  void setAtributos(float x, float y,float rad, float vel, float hp){
    this.posicion = new PVector(x,y);
    this.radio = rad;
    this.velocidad = vel;
    this.hp = hp;
  }
  void setPosicion(PVector pos){this.posicion = pos;}//
   
  public float getX(){return posicion.x;}//
  public float getY(){return posicion.y;}//
  public float getVel(){return velocidad;}//
  
  
  
  abstract void mover();
  abstract void dibujar();
  abstract void disparar();
  void restarVida(float i){this.hp -= i;}
  void murio(){this.isAlive = false;}
}
