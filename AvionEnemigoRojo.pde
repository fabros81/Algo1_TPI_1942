class AvionEnemigoRojo extends AvionEnemigo
{
 private boolean perteneceEscuadron;
 private int direccion = 1;
 private float tiempoActivacion; 
 private float tiempoInicioNivel;
 private Curva recorrido;
 private String curva;
 private int tiempoUltimoDisparo = 0;
 private int delayDisparo = int(random(1500, 4000));
 private Partida partida;
 

 public AvionEnemigoRojo(float x, float y)
 {
   super(x, y, 20, 2, 20, 100);
   this.perteneceEscuadron = false;
 }

 

 public void dibujar()
 { 

   if (!this.perteneceEscuadron){
     
     if (!isAlive) return;  
     fill(255,0,0);
     circle(this.posicion.x, this.posicion.y, this.radio);
  }else {
    if (this.tiempoActivacion + this.tiempoInicioNivel < millis()){
      if (!isAlive) return;  
      fill(255,0,0);
      image(enemigoR, this.posicion.x, this.posicion.y, this.radio, this.radio);
    }
    
      
    }
  
    
 }
 
 public void mover()
 {  
    if (!this.perteneceEscuadron){

      this.posicion.x += this.direccion * this.velocidad;
      
      //cuando pega con los bordes laterales, cambia direccion y baja en y
      if (this.posicion.x > width-30 || this.posicion.x <0)
      {
        this.direccion *= (-1);
        this.posicion.y += 50;
      }
    } else {
        this.go();
    }
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
   
 
  public void setPerteneceEscuadron (boolean t){this.perteneceEscuadron = t;}
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
