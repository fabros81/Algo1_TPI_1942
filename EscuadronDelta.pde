public class EscuadronDelta extends Escuadron{

    public EscuadronDelta(Partida p){
        super(p);
    }

    public void añadirEnemigo(int cant) {
        for (int i = 0; i < cant; i++) {
            AvionEnemigoRojo e = new AvionEnemigoRojo(100, -20);    
            e.setPartida(this.partida);
            e.setCurva("parabolaParametrica");
            e.setTiempoInicioNivel(millis());
            this.enemigos.add(e);
        }
    
        partida.listaEnemigos.addAll(this.enemigos);
    
    }

    public void mandar(float tAct){
        int cont = 0;
        for (AvionEnemigoRojo e : this.enemigos) {
            cont += 1;
            e.setTiempoActivacion(tAct + cont *500);
        }
   }

}