package eje2;
import eje1.GeneralTree;
import java.util.List;
import java.util.LinkedList;
import eje8.Queue;
public class RecorridosAG {
	
	public List<Integer> numerosImparesMayoresQuePreOrden(GeneralTree<Integer> a, Integer n){
		if(!a.isEmpty()){
			List<Integer> aux= new LinkedList<Integer>();
			if (n < a.getData() && !((a.getData()% 2) == 0)) aux.add(a.getData());
			if (a.hasChildren()) {
				for(GeneralTree<Integer> arbol: a.getChildren()) {
					aux.addAll(numerosImparesMayoresQuePreOrden(arbol,n));
				}
			}
			return aux;
		}else return null;
	}
	public List<Integer> numerosImparesMayoresQueInOrden (GeneralTree <Integer> a,
			Integer n){
		if(!a.isEmpty()) {
				List<Integer> aux= new LinkedList<Integer>();
				if(a.hasChildren()) {
					aux.addAll(numerosImparesMayoresQueInOrden(a.getChildren().get(0),n));
				}
				if(comparar(a.getData(),n)){ aux.add(a.getData()); }
				if (a.hasChildren()) {	
					for(int i =1 ; i< a.getChildren().size(); i++) {
						aux.addAll(numerosImparesMayoresQueInOrden(a.getChildren().get(i),n));
					}
				}
				return aux;
			} else return null;
	}
	
	public List<Integer> numerosImparesMayoresQuePostOrden (GeneralTree <Integer> a,
			Integer n){
		if (!a.isEmpty()) {
			List<Integer> aux = new LinkedList<Integer>();
			if (a.hasChildren()) {
			    for(GeneralTree<Integer> actual: a.getChildren()) {
			    	aux.addAll(numerosImparesMayoresQuePostOrden(actual, n));
			    }
			}
			if(n< a.getData() && !((a.getData()%2) == 0)) {aux.add(a.getData());}
			return aux;
		}else return null;
	}
	
	private boolean comparar(Integer num, Integer n) {
		return ((num%2) != 0  && num> n);
	}
	
	public List<Integer> numerosImparesMayoresQuePorNiveles(GeneralTree <Integer> a,
			Integer n){
		if (!a.isEmpty()) {
			List<Integer> aux= new LinkedList<Integer>();
			Queue<GeneralTree<Integer>> cola = new Queue<GeneralTree<Integer>>();
			cola.enqueue(a); cola.enqueue(null);
			GeneralTree<Integer> actual;
			while(!cola.isEmpty()){
				actual = cola.dequeue();
				if (actual != null) {
					if(comparar(actual.getData(),n)) {aux.add(actual.getData());}
					for(GeneralTree<Integer> data: actual.getChildren()) {
						cola.enqueue(data);
					}
				}else if (!cola.isEmpty()) cola.enqueue(null);
			}
			return aux;
		}else return null;
	}

	
}
