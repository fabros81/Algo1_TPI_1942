class PantallaFinal
{
  private GameManager gm;
  PFont font;
  
  PantallaFinal(GameManager gm)
  {
    this.gm = gm;
    font = createFont("Georgia", 32);
  }
  
  void dibujar()
  {
    background(0);    
    textFont(font);
    fill(255);
    text("FIN", width / 2 , 100);
    text("MENU (r)",  width / 2 , 400);
    

  }
  
  void actualizar()
  {
    
  }

}
