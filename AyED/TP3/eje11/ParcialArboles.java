package eje11;
import eje1.GeneralTree;
import eje8.Queue;
public class ParcialArboles {
	public static boolean resolver(GeneralTree<Integer> arbol) {
		boolean ok= true;
		Queue<GeneralTree<Integer>> cola = new Queue<GeneralTree<Integer>>();
		cola.enqueue(arbol); cola.enqueue(null); int ant= 1,suma=0;
		GeneralTree<Integer> aux = new GeneralTree<Integer>();
		while (!cola.isEmpty()) {
			aux= cola.dequeue();
            if (ok && aux != null) {
			  if (aux.hasChildren()) {
				  suma+= aux.getChildren().size();
				  for(GeneralTree<Integer> actual: aux.getChildren()) {
					  cola.enqueue(actual);
			    	}
			  }
            }else if (ok){
            	ok= (ant+1 == suma);
            	ant++;
            	suma = 0;
            	if (ok && !cola.isEmpty()) {
            		cola.enqueue(null);
            	}
            }
		}
		return ok;
	}

}
