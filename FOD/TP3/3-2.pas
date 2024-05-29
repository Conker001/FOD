{Definir un programa que genere un archivo con registros de longitud fija conteniendo
información de asistentes a un congreso a partir de la información obtenida por
teclado. Se deberá almacenar la siguiente información: nro de asistente, apellido y
nombre, email, teléfono y D.N.I. Implementar un procedimiento que, a partir del
archivo de datos generado, elimine de forma lógica todos los asistentes con nro de
asistente inferior a 1000.
Para ello se podrá utilizar algún carácter especial situándolo delante de algún campo
String a su elección. Ejemplo: ‘@Saldaño’.}
program Emanuel;
const
  valorAlto= 9999;
  marca= '@';
type
  asistentes = record
    numero: integer;
    apellido: string;
    nombre: string;
    email: string;
    telefono: integer;
    DNI: integer
  end;
  archivo= file of asistentes;
  procedure leer(var dato: archivo; var reg: asistentes);
  begin
    if (not eof(dato)) then read(dato,reg)
    else reg.numero:= valorAlto
  end;
  procedure eliminar(var arch: archivo);
  var
    actual: asistentes;
  begin
    assign(arch, 'asistentes'); reset(arch);
    leer(arch,actual);
    while(actual.numero <> valorAlto) do begin
      if (actual.numero < 1000) then begin
        actual.nombre:= marca+actual.nombre;
        seek(arch,filePos(arch)-1);
        write(arch,actual)
      end;
      leer(arch,actual)
    end;
    close(arch)
  end;
var
  arch: archivo;
begin
  eliminar(arch);
end.
