abstract class  Escuadron {
    protected ArrayList<AvionEnemigoRojo> enemigos;
    protected AvionEnemigoRojo enemigo;  
    protected boolean activo ;
    protected float tiempoActivacion;
    protected float tiempoInicioPartida;


    

  public Escuadron(float tInicioPartida){
    this.activo= false;
    this.tiempoInicioPartida = tInicioPartida;
  }
  
  public float getTiempoInicioPartida(){return this.tiempoInicioPartida;}
  public void addEnemigos(AvionEnemigoRojo e){this.enemigo = e;}
  public void setTiempoActivacion(float t){this.tiempoActivacion =t;}
  public void setEnemigo(AvionEnemigoRojo e){this.enemigo = e;}
  
  
  


  }
