package eje1;

import java.util.LinkedList;
import java.util.List;

public class GeneralTree<T>{

	private T data;
	private List<GeneralTree<T>> children = new LinkedList<GeneralTree<T>>(); 

	public GeneralTree() {
		
	}
	public GeneralTree(T data) {
		this.data = data;
	}

	public GeneralTree(T data, List<GeneralTree<T>> children) {
		this(data);
		this.children = children;
	}	
	public T getData() {
		return data;
	}

	public void setData(T data) {
		this.data = data;
	}

	public List<GeneralTree<T>> getChildren() {
		return this.children;
	}
	
	public void setChildren(List<GeneralTree<T>> children) {
		if (children != null)
			this.children = children;
	}
	
	public void addChild(GeneralTree<T> child) {
		this.getChildren().add(child);
	}

	public boolean isLeaf() {
		return !this.hasChildren();
	}
	
	public boolean hasChildren() {
		return !this.children.isEmpty();
	}
	
	public boolean isEmpty() {
		return this.data == null && !this.hasChildren();
	}

	public void removeChild(GeneralTree<T> child) {
		if (this.hasChildren())
			children.remove(child);
	}
	
	public int altura() {	 
			
		return 0;
	}
	
	public int nivel(T dato){
		return 0;
	  }

	public int ancho(){
		
		return 0;
	}
	
	public List<Integer> numerosImparesMayoresQuePreOrden (GeneralTree <Integer> a,
			Integer n){
		List<Integer> lista= new LinkedList<Integer>();
		if(!this.isEmpty()) {
			if (esImpar(a.getData(),n)) lista.add(a.getData());
			if (this.hasChildren()){
				for(GeneralTree<Integer> aux: a.getChildren()) {
					lista.addAll(aux.numerosImparesMayoresQuePreOrden(aux, n));
				}
			}
			
		}return lista;
		
	}
	public List<Integer> numerosImparesMayoresQueInOrden (GeneralTree <Integer> a,
			Integer n){
		List<Integer> lista = new LinkedList<Integer>();
		if(!this.isEmpty()) {
			if (a.hasChildren()) {
				lista.addAll(numerosImparesMayoresQueInOrden(a.getChildren().get(0),n));
			}
			if (esImpar((Integer)this.getData(),n)) {lista.add((Integer)this.getData());}
			for (int i=1; i< a.getChildren().size();i++) {
				lista.addAll(numerosImparesMayoresQueInOrden(a.getChildren().get(i),n));
			}
		}return lista;
	}
	private boolean esImpar(Integer actual, Integer n) {
		return (actual > n && !((actual%2)==0));
	}
	
	public boolean esAncestro(T a, T b) {
		boolean ok=false;
		if(!this.isEmpty() && !this.isLeaf()) {
			ok= comprobar(a,b,false,false);
		}
		
		return ok;
	}
	private boolean comprobar(T a,T b,boolean okA, boolean okB) {
		if(!okB && this.getData().equals(a)) okA= true;
		if(okA &&  this.getData().equals(b)) okB= true;
		if(!okB  && this.hasChildren()) {
			int i=0;
			while(!okB && i < this.getChildren().size()) {
				okB = comprobar(a,b,okA,okB);
				i++;
			}
		}
		return okA && okB;
	}
}