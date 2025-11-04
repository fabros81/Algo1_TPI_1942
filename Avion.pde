abstract class Avion
{
  protected PVector posicion;
  protected float radio;
  protected float velocidad;
  protected boolean isAlive = true;
  protected float hp;


  public Avion(float x, float y,float rad, float vel, float hp){
    this.posicion = new PVector(x,y);
    this.radio = rad;
    this.velocidad = vel;
    this.hp = hp;
  }  
   
  public float getX(){return this.posicion.x;}
  public float getY(){return this.posicion.y;}
  public float getVel(){return this.velocidad;}
  public float getR(){return  this.radio;}
  
  
  abstract void mover();
  abstract void dibujar();
  abstract void disparar();
  void restarVida(float i){this.hp -= i;}
  void murio(){this.isAlive = false;}
}
