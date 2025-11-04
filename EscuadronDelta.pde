public class EscuadronDelta extends Escuadron{

    public EscuadronDelta(Partida p){
        super(p);
    }

    public void añadirEnemigo(int cant) {
        for (int i = 0; i < cant; i++) {
            //AvionEnemigoRojo e = new AvionEnemigoRojo(820,-20); 
            AvionEnemigoRojo e = new AvionEnemigoRojo(400, -20);    
            e.setPerteneceEscuadron(true);
            e.setRecorrido(new Curva());
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
/*
   public void mandar(float tAct) {
    int nuevos = 0;
    for (int i = this.enemigos.size() - 3; i < this.enemigos.size(); i++) { // solo los últimos 3
        AvionEnemigoRojo e = this.enemigos.get(i);
        e.setTiempoActivacion(tAct + nuevos * 700);
        nuevos++;
    }
}*/

}