package eje5;
import eje1y2.BinaryTree;
import eje8.Queue;
public class ProfundidadDeArbolBinario {
	private BinaryTree<Integer> arbol = new BinaryTree<Integer>();
	
	public BinaryTree<Integer> getArbol() {
		return arbol;
	}

	public void setArbol(BinaryTree<Integer> arbol) {
		this.arbol = arbol;
	}

	public int sumaElementosProfundidad(int p) {
		Queue<BinaryTree<Integer>> cola = new Queue<BinaryTree<Integer>>();
		if (arbol.isEmpty()) {System.out.println("no hay elem"); return 0;}
		else {
			cola.enqueue(getArbol());
			cola.enqueue(null);
			int i=0,max=0; BinaryTree<Integer> aux;
			while(!cola.isEmpty() && i<=p) {
				aux= cola.dequeue();
				if(aux != null) {
					if(i == p) max+= aux.getData() ;  
					if(aux.hasLeftChild()) cola.enqueue(aux.getLeftChild());
				    if(aux.hasRightChild()) cola.enqueue(aux.getLeftChild());
				}else {
					i++;
					if(!cola.isEmpty()) cola.enqueue(null);
						}
			}// if i<p then "no existe esa prof."
			return max;
		
		}
	}	
	
	
	

}
