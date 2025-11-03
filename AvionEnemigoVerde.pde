class AvionEnemigoVerde extends AvionEnemigo
{
 
  public AvionEnemigoVerde(int x, int y)
  {
    super(x, y, 15, 4.5, 10, 50); 
  }
  
  public void dibujar()
 {
   if (!isAlive) return;  
   fill(0,255,0);
   circle(this.posicion.x, this.posicion.y, this.radio);
 }
 
 public void mover()
 { 
   this.posicion.y += this.velocidad;
   
   
   if (this.posicion.y > height+30)
   {
     murio();
   }
 }
 
 public void disparar()
 {

 }
 
}
