package eje7;
import eje1.GeneralTree;
import java.util.List;
import java.util.LinkedList;
public class Caminos {
	private GeneralTree<Integer> arbol;

	public Caminos(GeneralTree<Integer> arbol) {
		this.setArbol(arbol);
	}
	public Caminos() {}
	public GeneralTree<Integer> getArbol() {
		return arbol;
	}

	public void setArbol(GeneralTree<Integer> arbol) {
		this.arbol = arbol;
	}
	
	public List<Integer> caminoAHojaMasLejana(){
		List<Integer> lista = new LinkedList<Integer>();
		if (!getArbol().isEmpty()) {
			if (!getArbol().isLeaf()) {
				lista = sourceLength(getArbol());
			}else lista.add(getArbol().getData());
		}
		return lista;
	}
	private List<Integer> sourceLength(GeneralTree<Integer> arbol){
		List<Integer> listaL = new LinkedList<Integer>();
		listaL.add(arbol.getData());
		if (arbol.hasChildren()) {
			List<Integer> listaA = new LinkedList<Integer>();
			List<Integer> listaB = new LinkedList<Integer>();
			for(GeneralTree<Integer> actual: arbol.getChildren()) {
				listaA = sourceLength(actual);
				if (listaA.size() > listaB.size()) {
					listaB = new LinkedList<Integer>(listaA);
				}
			}
			listaL.addAll(listaB);
		}
		return listaL;
	}
}
