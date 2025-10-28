class AvionEnemigoVerde extends AvionEnemigo
{
 
  public AvionEnemigoVerde(GameManager gm, int x, int y)
  {
    super(gm,x, y, 15, 4.5, 10, 50); 
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
     this.isAlive = false;
   }
 }
 
 public void disparar()
 {
   if (!isAlive) return;
   
 }
 
}
