public class EscuadronBeta extends Escuadron{

    public EscuadronBeta(Partida p){
        super(p);
    }

    public void añadirEnemigo(int cant) {
        for (int i = 0; i < cant; i++) {
            AvionEnemigoRojo e = new AvionEnemigoRojo(820 + i * 60, -120 - i * 30);    
            e.setPartida(this.partida);
            e.setCurva("diagInv");
            e.setTiempoInicioNivel(millis());
            this.enemigos.add(e);
        }
    
        partida.listaEnemigos.addAll(this.enemigos);
    
    }

    public void mandar(float tAct){
        //int cont = 0;;
        for (AvionEnemigoRojo e : enemigos) {
            //cont += 1;
            e.setTiempoActivacion(tAct);
        }
   }
}