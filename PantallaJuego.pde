import processing.core.PVector;
class PantallaJuego
{
  
  private Partida partida;
  private GameManager gm;
  PFont font;
  
  PantallaJuego(GameManager gm)
  {
    this.gm = gm;
    this.font = createFont("Georgia", 32);
    
    

  }
  
  void dibujar()
  {
    
    background(0);
  
    this.partida.dibujar();
    
    textFont(font);
    fill(255);
    
    textAlign(LEFT, TOP);
    
    float puntaje = partida.getPuntos();
    String textoPuntaje = nf(puntaje, 0, 2);
    
    text(textoPuntaje, 20, 30);
    text(nf(partida.getPuntos(),0,2), 20 , 30);// esta puede que no vaya mas

  }
  
  void actualizar()
  {
  
    this.partida.actualizar();
  }

   void setPartida(Partida partida) {
    this.partida = partida;
  }
}
