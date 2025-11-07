abstract class AvionEnemigo extends Avion
{
  protected int puntos;
  public AvionEnemigo(float x, float y, float radio, float velocidad, float hp, int puntos) {
    super(x, y, radio, velocidad, hp);
    this.puntos = puntos;
  }
  
  //public float getTiempoActivacion(){};
  public void setTiempoActivacion(){};
  abstract void mover();
  abstract void dibujar();
  abstract void disparar();
  public int getPuntos(){return this.puntos;}
}
