package ej3;

public class Profesor extends Persona {

	private String Catedra;
	private String Facultad;
	
	public Profesor(String n, String a, String e, String c, String f) {
		super(n, a, e);
		this.setCatedra(c);
		this.setFacultad(f);
	}
	public String getCatedra() {
		return Catedra;
	}
	public void setCatedra(String catedra) {
		this.Catedra = catedra;
	}
	public String getFacultad() {
		return Facultad;
	}
	public void setFacultad(String facultad) {
		this.Facultad = facultad;
	}
	@Override
	public String tusDatos() {
		String datos=("nombre: "+ super.getNombre()+"apellido: "+ super.getApellido()+"email: "+ super.getEmail()+"catedra: "+this.getCatedra()+"facultad: "+this.getFacultad()) ;
		return datos;
	}

}
