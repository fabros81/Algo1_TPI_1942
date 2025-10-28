class AvionEnemigoRojo extends AvionEnemigo
{
 private int direccion = 1;
 
 public AvionEnemigoRojo(GameManager gm,float x, float y)
 {
   super(gm,x, y, 20, 3, 20, 100);
 }
 
 public void dibujar()
 {
   if (!isAlive) return;  
   fill(255,0,0);
   circle(this.posicion.x, this.posicion.y, this.radio);
 }
 
 public void mover()
 { 
   this.posicion.x += this.direccion * this.velocidad;
   
   //cuando pega con los bordes laterales, cambia direccion y baja en y
   if (this.posicion.x > width-30 || this.posicion.x <0)
   {
     this.direccion *= (-1);
     this.posicion.y += 50;
   }
   //si pasa el borde inferior, mueren
   if (this.posicion.y > height+30)
   {
     this.isAlive = false;
   }
 }
 private int tiempoUltimoDisparo = 0;     // Tiempo del último disparo
 private int delayDisparo = int(random(1500, 4000));
 public void disparar()
 {
   if (!isAlive) return;
   int tiempoActual = millis();

   if(tiempoActual - tiempoUltimoDisparo >= delayDisparo)
    {
      gm.getPartida().crearBalasEnemigas(this.posicion.x, this.posicion.y);
      tiempoUltimoDisparo = tiempoActual;
      delayDisparo = int(random(1000, 4000));
    }
  }
   
 
 
}
