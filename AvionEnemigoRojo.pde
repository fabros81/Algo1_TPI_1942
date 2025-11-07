class AvionEnemigoRojo extends AvionEnemigo
{
 public AvionEnemigoRojo(float x, float y)
 {
   super(x, y, 20, 2, 20, 100);
 }

 

 public void dibujar()
 { 


  if (this.tiempoActivacion + this.tiempoInicioNivel < millis()){
    if (!isAlive) return;  

    fill(255,0,0);
    image(enemigoR, this.posicion.x, this.posicion.y, this.radio, this.radio);
    }
  
    
 }
 
 public void mover()
 {  
    this.go();
    
    //si pasa el borde inferior, mueren
    if (this.posicion.y > height - 50)
    {
      murio();
    }
  }
 
  void go()
  {

    if (millis() - this.tiempoInicioNivel < this.tiempoActivacion) return;

     switch (this.curva) {
    case "diag":
      this.posicion = this.recorrido.diag(this.getX(), this.getY(), this.getVel());
      break;

    case "diagInv":
      this.posicion = this.recorrido.diagInv(this.getX(), this.getY(), this.getVel());
      break;

    case "parabolaParametrica":
      this.posicion = this.recorrido.parabolaParametrica(this.getX(), this.getY(), this.getVel());
      break;

    case "parabolaParametricaInv":
      this.posicion = this.recorrido.parabolaParametricaInv(this.getX(), this.getY(), this.getVel());
      break;

    case "rectaHorizontal":
      this.posicion = this.recorrido.rectaHorizontal(this.getX(), this.getY(), this.getVel());
      break;
    }
  }    



 
 public void disparar()
 {
   if (!isAlive) return;
   if (this.posicion.y > 10) //dispara solo si está en pantalla
   {
    int tiempoActual = millis();

    //evitar disparar justo al aparecer
    //if (millis() - this.tiempoInicioNivel < this.tiempoActivacion + 400) return;

    if(tiempoActual - tiempoUltimoDisparo >= delayDisparo)
      {
        partida.crearBalasEnemigas(this.posicion.x, this.posicion.y,  0, 1, 5, 9, 33.4);
        tiempoUltimoDisparo = tiempoActual;
        delayDisparo = int(random(1000, 4000));
      }
    }
  }
   
 



}
