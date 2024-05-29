package eje4;
import eje1y2.BinaryTree;
public class RedBinariaLlena {
	public int retardoReenvio(BinaryTree<Integer> arbol) {
		if (arbol.isEmpty()) return 0;
		else if (arbol.isLeaf()) return arbol.getData();
		else { int i=0,d=0;
		     if (arbol.hasLeftChild()) i= retardoReenvio(arbol.getLeftChild());
		     if (arbol.hasRightChild()) d= retardoReenvio(arbol.getRightChild());
		     return(Math.max(i,d));
		}
	}
}
