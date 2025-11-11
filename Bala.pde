class Bala
{
  // Atributos principales
  private PVector posicion;
  private float direccionX;
  private float direccionY;
  private float radio;
  private float velocidad;
  private boolean colisiono = false;
  private float daño;

  // Constructor
  public Bala(float x, float y, float dx, float dy, float vel, float r, float daño) {
    this.posicion = new PVector(x, y);
    this.direccionX = dx;
    this.direccionY = dy;
    this.velocidad = vel;
    this.radio = r;
    this.daño = daño;
  }

  // Dibujo y actualización
  public void dibujar() {
    if (!colisiono) {
      fill(255, 0, 0);
      circle(this.posicion.x, this.posicion.y, this.radio);
    }
  }

  public void mover() { // actúa como "actualizar"
    this.posicion.y += this.direccionY * this.velocidad;
    this.posicion.x += this.direccionX * this.velocidad;
  }

  // Otros métodos
  public void colisiono() { this.colisiono = true; } // marca impacto

  // Getters y setters
  public PVector getPosicion() { return this.posicion; }
  public float getDireccionX() { return this.direccionX; }
  public float getDireccionY() { return this.direccionY; }
  public float getRadio() { return this.radio; }
  public float getDaño() { return this.daño; }
  public boolean getColisiono() { return this.colisiono; }
}
