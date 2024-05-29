package eje1y2;

import eje8.Queue;

public class BinaryTree <T> {
	
	private T data;
	private BinaryTree<T> leftChild;   
	private BinaryTree<T> rightChild; 

	
	public BinaryTree() {
		super();
	}

	public BinaryTree(T data) {
		this.data = data;
	}

	public T getData() {
		return data;
	}

	public void setData(T data) {
		this.data = data;
	}
	/**
	 * Preguntar antes de invocar si hasLeftChild()
	 * @return
	 */
	public BinaryTree<T> getLeftChild() {
		return leftChild;
	}
	/**
	 * Preguntar antes de invocar si hasRightChild()
	 * @return
	 */
	public BinaryTree<T> getRightChild() {
		return this.rightChild;
	}

	public void addLeftChild(BinaryTree<T> child) {
		this.leftChild = child;
	}

	public void addRightChild(BinaryTree<T> child) {
		this.rightChild = child;
	}

	public void removeLeftChild() {
		this.leftChild = null;
	}

	public void removeRightChild() {
		this.rightChild = null;
	}

	public boolean isEmpty(){
		return (this.isLeaf() && this.getData() == null);
	}

	public boolean isLeaf() {
		return (!this.hasLeftChild() && !this.hasRightChild());

	}
		
	public boolean hasLeftChild() {
		return this.leftChild!=null;
	}

	public boolean hasRightChild() {
		return this.rightChild!=null;
	}
	@Override
	public String toString() {
		return this.getData().toString();
	}

	public  int contarHojas() {
	   int i = 0;
	   if (this.isEmpty()) return i;
	   else if (this.isLeaf()) return 1;
	   else {
		   if(this.hasLeftChild()) i = this.getLeftChild().contarHojas();
		   if(this.hasRightChild()) i+= this.getRightChild().contarHojas();
	   }
		return i;
	}
		
		
    	 
    public BinaryTree<T> espejo(){
		   BinaryTree<T> nuevo= new BinaryTree<T>();
		   if(this.isEmpty()) nuevo =  null;
		   else {nuevo.setData(this.data);
		   if (this.hasLeftChild()) nuevo.addRightChild(this.getRightChild().espejo());
		   if (this.hasRightChild()) nuevo.addLeftChild(this.leftChild.espejo());
		   }
 	   return nuevo;
    }

	// 0<=n<=m
	public void entreNiveles(int n, int m){
		Queue <BinaryTree<T>> cola = new Queue<BinaryTree<T>>();
		int i=0; BinaryTree<T> aux;
		if(!this.isEmpty()) {
			cola.enqueue(this);
			cola.enqueue(null);
			while(!cola.isEmpty() && (i <= m)) {
				aux= cola.dequeue();
				if (aux != null) {
					  if (i>=n && i<=m) aux.getData().toString();
					  if (aux.hasLeftChild()) cola.enqueue(aux.getLeftChild());
					  if (aux.hasRightChild()) cola.enqueue(aux.getLeftChild());
				}//if (aux == null) 
				else{
				    if (!cola.isEmpty()) {
				    	cola.enqueue(null);
				    	i++;
				    }
				}
			}
		}

    }
	
	
		
}

