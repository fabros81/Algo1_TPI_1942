class Bala
{
  private PVector posicion;
  private int direccion;
  private float radio;
  private float velocidad;
  private boolean colisiono = false;
  private float daño;
  public Bala(float x, float y,int d, float vel, float r, float daño)
  {
    this.posicion = new PVector(x,y);
    this.direccion = d;
    this.velocidad = vel;
    this.radio = r;
    this.daño = daño;
  }
   //getters
  public PVector getPosicion() {return this.posicion;}
  public int getDireccion() {return this.direccion;}
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
      this.posicion.y = this.posicion.y + this.direccion * this.velocidad;   
  }
    
}
