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
        this.jugador.activarMultidisparo();
    }
    public void escudo()
    {
        this.jugador.setEscudo(true);
    }
   
    public void instakill()
    {
        this.jugador.activarInstakill();
       
    }
}