class AvionEnemigoVerde extends AvionEnemigo
{
  private float tiempoActivacion;
  private float tiempoInicioNivel;
 
  public AvionEnemigoVerde(int x, int y)
  {
    super(x, y, 15, 4.5, 10, 50); 
    this.tiempoActivacion = 0;
    this.tiempoInicioNivel = 0;
  }
  
  public void dibujar()
 {
   if (!isAlive) return;  
   fill(0,255,0);
   image(enemigoV, this.posicion.x, this.posicion.y, this.radio,this.radio);
 }
 
 public void mover()
 { 
   go();
   
   if (this.posicion.y > height+30)
   {
     murio();
   }
 }

 public void go()
 {
    if (millis() - this.tiempoInicioNivel < this.tiempoActivacion) return;
    this.posicion = new PVector(this.posicion.x, this.posicion.y + this.getVel());
 }
 
 public void disparar()
 {

 }

  public void setTiempoInicioNivel(float t) { this.tiempoInicioNivel = t; }
  public void setTiempoActivacion(float t) { this.tiempoActivacion = t; }
 
}
