class PantallaEstadistica{
  private GameManager gm;
  private int delayTecla;
  private int ultimoMillisTecla;

  PantallaEstadistica(GameManager gm){
    this.gm = gm;
    this.delayTecla = 300;
    this.ultimoMillisTecla = 0;
  }

public void daleDona(){
}


public void dibujar(){
  
    background(0);
    fill(255);
    text("Dona! te espera esta pantalla", 50, height/2);

    text("press 'q' to exit",50, 100);

}
public void actualizar(){
  
  if(gm.getEscapePressed() ) { gm.setEstado(0); }
}
}
