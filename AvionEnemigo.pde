abstract class AvionEnemigo extends Avion
{
  protected int puntos;
  
  public AvionEnemigo(GameManager gm, float x, float y, float radio, float velocidad, float hp, int puntos) {
    super(gm,x, y, radio, velocidad, hp);
    this.puntos = puntos;
  }
  
    
  abstract void mover();
  abstract void dibujar();
  abstract void disparar();
  public int getPuntos(){return this.puntos;}
}
