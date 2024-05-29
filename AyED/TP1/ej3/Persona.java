package ej3;

public abstract class Persona {
  private String nombre;
  private String apellido;
  private String email;
  
public Persona(String n, String a, String e) {
	this.setNombre(n);
	this.setApellido(a);
	this.setEmail(e);
}
public String getNombre() {
	return nombre;
}
public void setNombre(String nombre) {
	this.nombre = nombre;
}
public String getApellido() {
	return apellido;
}
public void setApellido(String apellido) {
	this.apellido = apellido;
}
public String getEmail() {
	return email;
}
public void setEmail(String email) {
	this.email = email;
}
  
public abstract String tusDatos();
}
