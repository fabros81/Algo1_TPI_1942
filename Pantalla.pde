abstract class Pantalla {
  protected GameManager gm;

  Pantalla(GameManager gm) {
    this.gm = gm;
  }

    abstract void dibujar();
    abstract void actualizar(); 



}