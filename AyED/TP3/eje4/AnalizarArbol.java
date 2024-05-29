package eje4;
import eje1.GeneralTree;
import eje8.Queue;
public class AnalizarArbol {
	public double devolverMaximoPromedio (GeneralTree<AreaEmpresa>arbol) {
		double promedio = 0;
		if (!arbol.isEmpty()) {
			if(!arbol.isLeaf()) {
				promedio= MaximoPromedio(arbol);
			}else promedio = arbol.getData().getTardanza();
		}
		return promedio;
	}
	private double MaximoPromedio(GeneralTree<AreaEmpresa> arbol) {
		double prom=0,promactual = 0; int size=0;
		GeneralTree<AreaEmpresa> actual;
		Queue<GeneralTree<AreaEmpresa>> cola= new Queue<GeneralTree<AreaEmpresa>>();
		cola.enqueue(arbol); cola.enqueue(null);
		while (!cola.isEmpty()) {
			actual= cola.dequeue();
			if(actual != null) {
				if(actual.hasChildren()) {
					for(GeneralTree<AreaEmpresa> nodo: actual.getChildren()) {
						cola.enqueue(nodo);
						promactual+= nodo.getData().getTardanza();
						size++;
					}
				}
			}else{
				prom= Math.max(prom, (promactual/size));
				if(!cola.isEmpty()){
					promactual =0; size= 0;
					cola.enqueue(null);}
			}
		}
		
		return prom;
	}

}
