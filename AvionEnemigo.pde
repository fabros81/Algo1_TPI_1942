abstract class AvionEnemigo extends Avion
{
  protected int puntos;
  protected int direccion = 1;
  protected float tiempoActivacion; 
  protected float tiempoInicioNivel;
  protected Curva recorrido;
  protected String curva;
  protected int tiempoUltimoDisparo = 0;
  protected int delayDisparo = int(random(1500, 4000));
  protected Partida partida;

  public AvionEnemigo(float x, float y, float radio, float velocidad, float hp, int puntos) {
    super(x, y, radio, velocidad, hp);
    this.puntos = puntos;
    this.recorrido = new Curva();
  }
  
    
  abstract void mover();
  abstract void dibujar();
  abstract void disparar();
  abstract void go();
  public int getPuntos(){return this.puntos;}
  public float getTiempoActivacion(){return this.tiempoActivacion;}
  public void setTiempoActivacion(float tAct) {
    this.tiempoActivacion = tAct;
    // resetear tiempoUltimoDisparo al activarse el avión para evitar disparos inmediatos
    this.tiempoUltimoDisparo = millis() + int(random(1000, 4000)); 
  }

  public void setTiempoInicioNivel(float tIni){this.tiempoInicioNivel = tIni;}
  public void setRecorrido(Curva r){this.recorrido = r;}
  public void setCurva(String c){this.curva = c;}
  public void setPartida(Partida p){this.partida = p;}

}
