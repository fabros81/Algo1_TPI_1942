public class EscuadronEpsilon extends Escuadron{

    public EscuadronEpsilon(Partida p){
        super(p);
    }

    public void añadirEnemigo(int cant) {
        if (cant <= 0) {
            println("Advertencia: La cantidad de enemigos debe ser mayor a cero.");
            return;
        }
        for (int i = 0; i < cant; i++) {
            AvionEnemigoRojo e = new AvionEnemigoRojo(100 + i * 100, 0);
            e.setPartida(this.partida);    
            e.setCurva("rectaHorizontal");
            e.setTiempoInicioNivel(millis());
            this.enemigos.add(e);
        }
    
        partida.getListaEnemigos().addAll(this.enemigos);
    
    }

    public void añadirEnemigoEspejo(int cant) {
        if (cant <= 0) {
            println("Advertencia: La cantidad de enemigos debe ser mayor a cero.");
            return;
        }
        for (int i = 0; i < cant; i++) {
            //primera linea
            AvionEnemigoRojo e = new AvionEnemigoRojo(100 + i * 100, 0);    
            e.setPartida(this.partida);
            e.setCurva("rectaHorizontal");
            e.setTiempoInicioNivel(millis());
            this.enemigos.add(e);

            //segunda linea espejo
            AvionEnemigoRojo e2 = new AvionEnemigoRojo(700 - i * 100, 0);  
            e2.setPartida(this.partida);
            e2.setCurva("rectaHorizontal");
            e2.setTiempoInicioNivel(millis());
            this.enemigos.add(e2);


        }
    
        partida.getListaEnemigos().addAll(this.enemigos);
    
    }


    public void mandar(float tAct){
        for (AvionEnemigoRojo e : this.enemigos) {
            e.setTiempoActivacion(tAct);
        }
   }
}