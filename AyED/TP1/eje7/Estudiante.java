package eje7;

public class Estudiante extends Persona {
  private String Comision;
  private String Direccion;
public Estudiante () {}
public Estudiante(String n, String a, String e, String c, String d) {
	super(n, a, e);
	this.setComision(c);
	this.setDireccion(d);
}
public String getComision() {
	return Comision;
}
public void setComision(String comision) {
	this.Comision = comision;
}
public String getDireccion() {
	return Direccion;
}
public void setDireccion(String direccion) {
	this.Direccion = direccion;
}
@Override
public String tusDatos() {
	String datos= ("nombre: "+super.getNombre() +"/n apellido: "+ super.getApellido()+ "/n email: "+super.getEmail()+ "/n comision: "+this.getComision()+ "/n direccion: "+this.getDireccion());
	return datos;
}

}
