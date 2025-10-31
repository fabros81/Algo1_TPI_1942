class PowUp
{
    private AvionAliado jugador;
    private GameManager gm;
    private Partida partida;
    public PowUp(GameManager gm, AvionAliado jugador)
    {
        this.jugador = jugador;
        this.gm = gm;
      
    }
    
    public void multidisparo()
    {
      gm.getPartida().crearBalasAliadas(this.jugador.posicion.x , this.jugador.posicion.y, 0, -1, 8, 9, 10); // arriba
      gm.getPartida().crearBalasAliadas(this.jugador.posicion.x , this.jugador.posicion.y, 0, 1, 8, 9, 10); // abajo 
      gm.getPartida().crearBalasAliadas(this.jugador.posicion.x , this.jugador.posicion.y, 1, 0, 8, 9, 10); // derecha
      gm.getPartida().crearBalasAliadas(this.jugador.posicion.x , this.jugador.posicion.y, -1, 0, 8, 9, 10); // izquierda
      gm.getPartida().crearBalasAliadas(this.jugador.posicion.x , this.jugador.posicion.y, -1, 1, 8, 9, 10); // abajo izquierda
      gm.getPartida().crearBalasAliadas(this.jugador.posicion.x , this.jugador.posicion.y, 1, 1, 8, 9, 10); // abajo derecha
      gm.getPartida().crearBalasAliadas(this.jugador.posicion.x , this.jugador.posicion.y, -1, -1, 8, 9, 10); // arriba izquierda
      gm.getPartida().crearBalasAliadas(this.jugador.posicion.x , this.jugador.posicion.y, 1, -1, 8, 9, 10); // arriba derecha
    }
    public void escudo()
    {

    }
    public void aumentoVelocidad()
    {
        this.jugador.aumentoVelocidad(this.jugador.getVelocidad()+1);
    }
    public void instakill()
    {
        gm.getPartida().crearBalasAliadas(this.jugador.posicion.x , this.jugador.posicion.y, 0, -1, 8, 9, 1000); 
    }
}