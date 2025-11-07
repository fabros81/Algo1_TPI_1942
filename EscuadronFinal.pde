public class EscuadronFinal extends Escuadron{

    public EscuadronFinal(Partida p){
        super(p);
    }

    public void añadirEnemigo(int cant) {
        
        AvionEnemigoJefeFinal e = new AvionEnemigoJefeFinal(400, -200);  
        e.setPartida(this.partida);
        e.setTiempoInicioNivel(millis());
        partida.listaEnemigos.add(e);
        
    
    }

    

    public void mandar(float tAct){
        //int cont = 0;;
        for (AvionEnemigoRojo e : enemigos) {
            //cont += 1;
            e.setTiempoActivacion(tAct);
        }
   }

   
}