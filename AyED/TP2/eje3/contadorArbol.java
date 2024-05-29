package eje3;

import eje1y2.BinaryTree;
import java.util.ArrayList;
import java.util.Scanner;

public class contadorArbol {
	private BinaryTree<Integer> arbol;

	public contadorArbol(BinaryTree<Integer> actual) {
		this.setArbol(actual);
	}
	
	public ArrayList<Integer> numerosPares(){
		Scanner op= new Scanner(System.in);
		System.out.println("1: inOrden; 2: postOrden");
		int i= op.nextInt();
		ArrayList<Integer > lista=null;;
		switch (i){
		case 1: {lista= inOrden(getArbol()); 
		         break;}
		case 2:{ lista = postOrden(getArbol()); 
		        break;}
		default: {System.out.println("numero invalido"); break;}
		}
		return lista;
	}
	private ArrayList<Integer> inOrden(BinaryTree<Integer> arbol ){
		ArrayList<Integer> actual = new ArrayList<Integer>();
		if(arbol.isEmpty())
		  return null;
		else{
			if (arbol.hasLeftChild()) actual.addAll(inOrden(arbol.getLeftChild()));
			actual.add(arbol.getData());
			if (arbol.hasRightChild()) actual.addAll(inOrden(arbol.getRightChild()));
			return actual;
		}
	}
	
	private ArrayList<Integer> postOrden(BinaryTree<Integer> arbol ){
		ArrayList<Integer> actual = new ArrayList<Integer>();
		if(arbol.isEmpty())
		  return null;
		else{
			if (arbol.hasLeftChild()) actual.addAll(inOrden(arbol.getLeftChild()));
			if (arbol.hasRightChild()) actual.addAll(inOrden(arbol.getRightChild()));
			actual.add(arbol.getData());
			return actual;
		}
	}
	public BinaryTree<Integer> getArbol() {
		return arbol;
	}

	public void setArbol(BinaryTree<Integer> arbol) {
		this.arbol = arbol;
	}
   
}
