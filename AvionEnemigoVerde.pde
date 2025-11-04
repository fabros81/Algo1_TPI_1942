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
   circle(this.posicion.x, this.posicion.y, this.radio);
 }
 
 public void mover()
 { 
   if (millis() - tiempoInicioNivel < tiempoActivacion) return;
    this.posicion.y += this.velocidad;
   
   if (this.posicion.y > height+30)
   {
     murio();
   }
 }
 
 public void disparar()
 {

 }

  public void setTiempoInicioNivel(float t) { this.tiempoInicioNivel = t; }
  public void setTiempoActivacion(float t) { this.tiempoActivacion = t; }
 
}
