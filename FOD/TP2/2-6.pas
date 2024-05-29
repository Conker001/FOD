{
* Suponga que trabaja en una oficina donde está montada una LAN (red local). La misma fue
construida sobre una topología de red que conecta 5 máquinas entre sí y todas las
máquinas se conectan con un servidor central. Semanalmente cada máquina genera un
archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y por
cuánto tiempo estuvo abierta. Cada archivo detalle contiene los siguientes campos:
cod_usuario, fecha, tiempo_sesion. Debe realizar un procedimiento que reciba los archivos
detalle y genere un archivo maestro con los siguientes datos: cod_usuario, fecha,
tiempo_total_de_sesiones_abiertas.
Notas:
● Cada archivo detalle está ordenado por cod_usuario y fecha.
● Un usuario puede iniciar más de una sesión el mismo día en la misma máquina, o
inclusive, en diferentes máquinas.
● El archivo maestro debe crearse en la siguiente ubicación física: /var/log.}
program emanuel;
const
  valorAlto= 9999;
type
  sesiones= record
    codigo: integer;
    fecha: string;
    tiempo: real;
  end;
  maestro= file of sesiones;
  detalle = array[1..5] of maestro;
  sesion= array[1..5] of sesiones;
  procedure iniciar(var mae: maestro; var det: detalle);
  var
    i: integer;
  begin
    assign(mae,''); 
    rewrite(mae);
    for i:= 1 to 5 do begin
      assign(det[i],'');
      reset(det[i])
      end
  end;
  procedure crear(var mae: maestro; var det: detalle);
    procedure leer(var det:maestro; var reg: sesiones);
    begin
      if (not eof (det)) then read(det,reg)
      else reg.codigo:= valorAlto
    end;
    procedure leo(var det: detalle; var regd: sesion);
    var
      i: integer;
    begin
      for i:= 1 to 5 do
        leer(det[i],regd[i])
    end;
    procedure minimo(var actual: sesiones; var det: detalle; var regd: sesion);
    var
      i,save: integer;
    begin
      actual.codigo:= valorAlto;
      for i:= 1 to 5 do begin
        if (regd[i].codigo < actual.codigo) then begin
          actual:= regd[i];
          save:= i
        end
      end;
      if (actual.codigo <> valorAlto) then leer(det[save],regd[save])
    end;
  var
    regm,actual: sesiones;
    regd: sesion;
  begin
    leo(det,regd);
    minimo(actual,det,regd);
    while (actual.codigo <> valorAlto)do begin
      regm.codigo:= actual.codigo;
      while(regm.codigo = actual.codigo) do begin
        regm.fecha:= actual.fecha;
        regm.tiempo:= 0;
        while ((regm.codigo = actual.codigo) and (regm.fecha = actual.fecha)) do begin
          regm.tiempo:= regm.tiempo+ actual.tiempo;
          minimo(actual,det,regd)
          end;
        write(mae,regm);
      end;
    end
  end;
  procedure cerrar(var mae: maestro; var det: detalle);
  var
    i: integer;
  begin
    close(mae);
    for i := 1 to 5 do
      close(det[i])
  end;
var
  mae: maestro;
  det: detalle;
begin
  iniciar(mae, det);
  crear(mae,det);
  cerrar(mae, det)
end.
