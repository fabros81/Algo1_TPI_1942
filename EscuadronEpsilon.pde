public class EscuadronEpsilon extends Escuadron{

    public EscuadronEpsilon(Partida p){
        super(p);
    }

    public void añadirEnemigo(int cant) {
        for (int i = 0; i < cant; i++) {
            AvionEnemigoRojo e = new AvionEnemigoRojo(100 + i * 100, 0);
            e.setPartida(this.partida);    
            e.setPerteneceEscuadron(true);
            e.setRecorrido(new Curva());
            e.setCurva("rectaHorizontal");
            e.setTiempoInicioNivel(millis());
            this.enemigos.add(e);
        }
    
        partida.listaEnemigos.addAll(this.enemigos);
    
    }

    public void añadirEnemigoEspejo(int cant) {
        for (int i = 0; i < cant; i++) {
            //primera linea
            AvionEnemigoRojo e = new AvionEnemigoRojo(100 + i * 100, 0);    
            e.setPartida(this.partida);
            e.setPerteneceEscuadron(true);
            e.setRecorrido(new Curva());
            e.setCurva("rectaHorizontal");
            e.setTiempoInicioNivel(millis());
            this.enemigos.add(e);

            //segunda linea espejo
            AvionEnemigoRojo e2 = new AvionEnemigoRojo(700 - i * 100, 0);  
            e2.setPartida(this.partida);
            e2.setPerteneceEscuadron(true);
            e2.setRecorrido(new Curva());
            e2.setCurva("rectaHorizontal");
            e2.setTiempoInicioNivel(millis());
            this.enemigos.add(e2);


        }
    
        partida.listaEnemigos.addAll(this.enemigos);
    
    }


    public void mandar(float tAct){
        for (AvionEnemigoRojo e : this.enemigos) {
            e.setTiempoActivacion(tAct);
        }
   }
}