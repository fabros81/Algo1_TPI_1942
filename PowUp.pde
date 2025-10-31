class PowUp
{
    private AvionAliado jugador;
    private Partida partida;
    public PowUp(Partida partida)
    {       
        this.partida = partida;
        this.jugador = this.partida.getJugador();
    }

    public void multidisparo()
    {
      partida.crearBalasAliadas(this.jugador.posicion.x , this.jugador.posicion.y, 0, -1, 8, 9, 10); // arriba
      partida.crearBalasAliadas(this.jugador.posicion.x , this.jugador.posicion.y, 0, 1, 8, 9, 10); // abajo 
      partida.crearBalasAliadas(this.jugador.posicion.x , this.jugador.posicion.y, 1, 0, 8, 9, 10); // derecha
      partida.crearBalasAliadas(this.jugador.posicion.x , this.jugador.posicion.y, -1, 0, 8, 9, 10); // izquierda
      partida.crearBalasAliadas(this.jugador.posicion.x , this.jugador.posicion.y, -1, 1, 8, 9, 10); // abajo izquierda
      partida.crearBalasAliadas(this.jugador.posicion.x , this.jugador.posicion.y, 1, 1, 8, 9, 10); // abajo derecha
      partida.crearBalasAliadas(this.jugador.posicion.x , this.jugador.posicion.y, -1, -1, 8, 9, 10); // arriba izquierda
      partida.crearBalasAliadas(this.jugador.posicion.x , this.jugador.posicion.y, 1, -1, 8, 9, 10); // arriba derecha
    }
    public void escudo()
    {
        this.jugador.setEscudo(true);
    }
   
    public void instakill()
    {
       partida.crearBalasAliadas(this.jugador.posicion.x , this.jugador.posicion.y, 0, -1, 8, 9, 1000); 
    }
}