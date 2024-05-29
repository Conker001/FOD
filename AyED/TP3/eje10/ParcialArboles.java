package eje10;
import eje1.GeneralTree;
import java.util.List;
import java.util.Arrays;
import java.util.LinkedList;
public class ParcialArboles {
	public static List<Integer> resolver(GeneralTree<Integer> arbol){
		List<Integer> lista = new LinkedList<Integer>();
		if(!arbol.isEmpty()) {
			if (!arbol.isLeaf()) {
				lista= buscarCamino(arbol,0);
				lista.removeAll(Arrays.asList(0));
			}else lista.add(0);
		}
		return lista;
	}
	private static List<Integer> buscarCamino(GeneralTree<Integer> arbol, int nivel){
		List<Integer> lista = new LinkedList<Integer>();
		lista.add(arbol.getData());
		if (arbol.hasChildren()) {
			List<Integer> listaSave= new LinkedList<Integer>();
			for(GeneralTree<Integer> actual: arbol.getChildren()) {
				List<Integer>listaActual= new LinkedList<Integer>(buscarCamino(actual,nivel+1));
				listaSave = comparar(listaSave,listaActual,nivel+1);
			}
			lista.addAll(listaSave);
		}
		return lista;
	}
	private static List<Integer> comparar(List<Integer> lista1, List<Integer> lista2,int nivel){
		List<Integer> listaG = new LinkedList<Integer>();
		int valorl1=0, valorl2=0;
		for (int i=0; i<lista1.size();i++) {
			valorl1+= (nivel+i)*lista1.get(i);
		}
		for(int i=0; i<lista2.size();i++) {
			valorl2+= (nivel+i)*lista2.get(i);
		}
		if (valorl1 > valorl2) {
			listaG.addAll(lista1);
		}else listaG.addAll(lista2);
		return listaG;
	}
	
	
	public static void main(String[] args) {
        List<GeneralTree<Integer>> subChildren1 = new LinkedList<GeneralTree<Integer>>();
        subChildren1.add(new GeneralTree<Integer>(1));
        subChildren1.add(new GeneralTree<Integer>(1));
        subChildren1.add(new GeneralTree<Integer>(1));
        GeneralTree<Integer> subA = new GeneralTree<Integer>(1, subChildren1);
        List<GeneralTree<Integer>> subChildren2 = new LinkedList<GeneralTree<Integer>>();
        subChildren2.add(subA);
        subChildren2.add(new GeneralTree<Integer>(1));
        GeneralTree<Integer> a1 = new GeneralTree<Integer>(0, subChildren2);
        
        List<GeneralTree<Integer>> subChildren3 = new LinkedList<GeneralTree<Integer>>();
        subChildren3.add(new GeneralTree<Integer>(1));
        GeneralTree<Integer> subB = new GeneralTree<Integer>(0, subChildren3);
        List<GeneralTree<Integer>> subChildren4 = new LinkedList<GeneralTree<Integer>>();
        subChildren4.add(subB);
        GeneralTree<Integer> subC = new GeneralTree<Integer>(0, subChildren4);
        List<GeneralTree<Integer>> subChildren5 = new LinkedList<GeneralTree<Integer>>();
        subChildren5.add(new GeneralTree<Integer>(1));
        subChildren5.add(subC);
        GeneralTree<Integer> a2 = new GeneralTree<Integer>(1, subChildren5);
        
        List<GeneralTree<Integer>> subChildren6 = new LinkedList<GeneralTree<Integer>>();
        subChildren6.add(new GeneralTree<Integer>(0));
        subChildren6.add(new GeneralTree<Integer>(0));
        GeneralTree<Integer> subD = new GeneralTree<Integer>(0, subChildren6);
        List<GeneralTree<Integer>> subChildren7 = new LinkedList<GeneralTree<Integer>>();
        subChildren7.add(subD);
        GeneralTree<Integer> subE = new GeneralTree<Integer>(0, subChildren7);
        List<GeneralTree<Integer>> subChildren8 = new LinkedList<GeneralTree<Integer>>();
        subChildren8.add(subE);
        GeneralTree<Integer> a3 = new GeneralTree<Integer>(1, subChildren8);
        
        List<GeneralTree<Integer>> arbol = new LinkedList<GeneralTree<Integer>>();
        arbol.add(a1);
        arbol.add(a2);
        arbol.add(a3);
        GeneralTree<Integer> a = new GeneralTree<Integer>(1, arbol);
        
        System.out.println(resolver(a));
        
    }
}
