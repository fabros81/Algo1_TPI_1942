class Bala
{
  private PVector posicion;
  private int direccionX;
  private int direccionY;
  private float radio;
  private float velocidad;
  private boolean colisiono = false;
  private float daño;
  public Bala(float x, float y,int dx, int dy, float vel, float r, float daño)
  {
    this.posicion = new PVector(x,y);
    this.direccionX = dx;
    this.direccionY = dy;
    this.velocidad = vel;
    this.radio = r;
    this.daño = daño;
  }
   //getters
  public PVector getPosicion() {return this.posicion;}
  public int getDireccionX() {return this.direccionX;}
  public int getDireccionY() {return this.direccionY;}
  public float getRadio() { return this.radio; }
  public float getDaño(){return this.daño;}
  public boolean getColisiono(){return this.colisiono;}
  
  
  public void colisiono(){this.colisiono = true;}

  public void dibujar()
  {   
    if (!colisiono)
    {
      fill(255,0,0);
      circle(this.posicion.x, this.posicion.y, this.radio);
    }
  }

  public void mover()
  {
    this.posicion.y = this.posicion.y + this.direccionY * this.velocidad;   
    this.posicion.x = this.posicion.x + this.direccionX * this.velocidad; 
  }
    
}
