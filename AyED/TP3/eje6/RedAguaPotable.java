package eje6;
import eje1.GeneralTree;
public class RedAguaPotable {
	private GeneralTree<Character> arbol;
	public RedAguaPotable(GeneralTree<Character> arbol) {
		this.setArbol(arbol);
	}
	public GeneralTree<Character> getArbol() {
		return arbol;
	}
	public void setArbol(GeneralTree<Character> arbol) {
		this.arbol = arbol;
	}
	public double minimoCaudal(double caudal) {
		if(!arbol.isEmpty()) {
			if(!arbol.isLeaf()) {
				caudal = buscarMin(arbol,caudal);
			}
		}else caudal = 0;
		return caudal;
	}
	private double buscarMin(GeneralTree<Character> arbol,double caudal) {
		double actualC = Double.MAX_VALUE;
		if (arbol.hasChildren()) {
			caudal= (double)caudal/arbol.getChildren().size();
			for(GeneralTree<Character> actual: arbol.getChildren()) {
				actualC= (double)Math.min(actualC,(buscarMin(actual,caudal)));
			}
		}
		return (double)Math.min(actualC, caudal);
	}

}
