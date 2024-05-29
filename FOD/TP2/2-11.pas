{La empresa de software ‘X’ posee un servidor web donde se encuentra alojado el sitio web
de la organización. En dicho servidor, se almacenan en un archivo todos los accesos que se
realizan al sitio. La información que se almacena en el archivo es la siguiente: año, mes, día,
idUsuario y tiempo de acceso al sitio de la organización. El archivo se encuentra ordenado
por los siguientes criterios: año, mes, día e idUsuario.
Se debe realizar un procedimiento que genere un informe en pantalla, para ello se indicará
el año calendario sobre el cual debe realizar el informe. El mismo debe respetar el formato
mostrado a continuación:
Año : ---
Mes:-- 1
día:-- 1
idUsuario 1 Tiempo Total de acceso en el dia 1 mes 1
--------
idusuario N Tiempo total de acceso en el dia 1 mes 1
Tiempo total acceso dia 1 mes 1
-------------
día N
idUsuario 1 Tiempo Total de acceso en el dia N mes 1
--------
idusuario N Tiempo total de acceso en el dia N mes 1
Tiempo total acceso dia N mes 1
Total tiempo de acceso mes 1
------
Mes 12
día 1
idUsuario 1 Tiempo Total de acceso en el dia 1 mes 12
--------
idusuario N Tiempo total de acceso en el dia 1 mes 12
Tiempo total acceso dia 1 mes 12
-------------
día N
idUsuario 1 Tiempo Total de acceso en el dia N mes 12
--------
idusuario N Tiempo total de acceso en el dia N mes 12
Tiempo total acceso dia N mes 12
Total tiempo de acceso mes 12
Total tiempo de acceso año
Se deberá tener en cuenta las siguientes aclaraciones:
● El año sobre el cual realizará el informe de accesos debe leerse desde el teclado.
● El año puede no existir en el archivo, en tal caso, debe informarse en pantalla “año
no encontrado”.
● Debe definir las estructuras de datos necesarias.
● El recorrido del archivo debe realizarse una única vez procesando sólo la información
necesaria.}
program Emanuel;
const
  valorAlto= 9999;
type
  archivo= record
    anio: integer;
    mes: integer;
    dia: integer;
    id: integer;
    tiempo: real
  end;
  actual = record
    dato: integer;
    tiempo: real;
  end;
  maestro = file of archivo;
  procedure leer(var mae: maestro; var reg: archivo);
  begin
    if(not eof (mae)) then read(mae,reg)
    else reg.anio:= valorAlto;
  end;
  procedure buscar(var mae: maestro; var reg: archivo);
  var
    i: integer;
  begin
    writeln('año a buscar');readln(i);
    leer(mae,reg);
    while((reg.anio <> valorAlto)and (i <> reg.anio)) do
      leer(mae, reg)
  end;
  procedure informar(var mae: maestro);
  var
    reg: archivo;
    xanio,xmes,xdia,xid: actual;
  begin
    buscar(mae,reg);
    if (reg.anio <> valorAlto) then begin
      xanio.dato:= reg.anio; xanio.tiempo:= 0; writeln('año: ' ,xanio.dato);
      while(reg.anio = xanio.dato) do begin
        xmes.dato:= reg.mes; xmes.tiempo:= 0; writeln('mes: ',xmes.dato);
        while((reg.anio = xanio.dato) and (xmes.dato = reg.mes)) do begin
          xdia.dato:= reg.dia; xdia.tiempo:= 0;writeln('dia: ',xdia.dato);
          while ((reg.anio = xanio.dato) and (xmes.dato = reg.mes) and (xdia.dato = reg.dia)) do begin
            xid.dato:= reg.id; xid.tiempo:= 0;
            while ((reg.anio = xanio.dato)and(xmes.dato = reg.mes) and (xdia.dato = reg.dia)and (xid.dato = reg.id)) do begin
              xid.tiempo:= xid.tiempo + reg.tiempo;
              
              leer(mae,reg)
            end;
            //id
            writeln('id Usuario: ',xid.dato,'tiempo total en el dia: ', xdia.dato,'mes: ', xmes.dato);
            writeln(xid.tiempo);
            xdia.tiempo:= xdia.tiempo+ xid.tiempo;    
          end;
          //dia
          writeln('tiempo total de acceso en el dia ', xdia.dato,'mes ' ,xmes.dato, 'es: ', xdia.tiempo);
          xmes.tiempo:= xmes.tiempo+ xdia.tiempo;
        end;
        writeln('tiempo total de acceso en el mes ', xmes.dato,': ', xmes.tiempo);
        xanio.tiempo:= xanio.tiempo + xmes.tiempo;
      end;
      writeln('monto total de acceso al año ', xanio.dato, ' : ', xanio.tiempo);
    end
    else writeln('año no encontrado')
  end;
var
  mae: maestro;
begin
  assign(mae,'maestro'); reset(mae);
  informar(mae);
  close(mae)
end.
