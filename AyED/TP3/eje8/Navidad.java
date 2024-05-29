package eje8;
import eje1.GeneralTree;
public class Navidad {
	private GeneralTree<Integer> abeto;
	
	public Navidad(GeneralTree<Integer> abeto) {
		this.setAbeto(abeto);
	}
	public GeneralTree<Integer> getAbeto() {
		return abeto;
	}

	public void setAbeto(GeneralTree<Integer> abeto) {
		this.abeto = abeto;
	}

	public String esAbetoNavidenio() {
		String verif="no";
		if (!this.getAbeto().isEmpty() && !this.getAbeto().isLeaf()) {
			verif = comprobarAbeto(this.getAbeto());
		}
		return verif;
	}
	private String comprobarAbeto(GeneralTree<Integer> abeto) {
		String esAbeto = "yes";
		if (abeto.hasChildren()) {
			int NHojas= 0, indice= 0;
			while(esAbeto.equals("yes") && indice < abeto.getChildren().size()) {
				if (abeto.getChildren().get(indice).isLeaf()) {
					NHojas++;
				}else esAbeto= comprobarAbeto(abeto.getChildren().get(indice));
				indice++;
			}
			if (!(NHojas >= 3 && esAbeto.equals("yes"))) esAbeto= "no";
		}
		return esAbeto;
	}

}
