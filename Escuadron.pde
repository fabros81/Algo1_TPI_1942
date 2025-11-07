abstract class  Escuadron {
    protected ArrayList<AvionEnemigoRojo> enemigos; 
    protected boolean activo ;
    protected float tiempoActivacion;
    protected float tiempoInicioNivel;
    protected Partida partida;


  public Escuadron(Partida p){
    this.partida = p;
    this.activo= false;
    this.tiempoInicioNivel = p.getTiempoInicioNivel();
    this.enemigos = new ArrayList<AvionEnemigoRojo>();
  }
  
  public float getTiempoInicioNivel(){return this.tiempoInicioNivel;}
  public void setTiempoActivacion(float t){this.tiempoActivacion =t;}
  public ArrayList<AvionEnemigoRojo> getEnemigos(){return this.enemigos;}
  
  abstract void añadirEnemigo(int cant);
  protected void añadirEnemigoEspejo(int cant){}
  abstract void mandar(float tAct);


}