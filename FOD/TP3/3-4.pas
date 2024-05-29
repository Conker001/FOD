{Dada la siguiente estructura:
type
reg_flor = record
nombre: String[45];
codigo:integer;
end;
tArchFlores = file of reg_flor;
Las bajas se realizan apilando registros borrados y las altas reutilizando registros
borrados. El registro 0 se usa como cabecera de la pila de registros borrados: el
número 0 en el campo código implica que no hay registros borrados y -N indica que el
próximo registro a reutilizar es el N, siendo éste un número relativo de registro válido.
a. Implemente el siguiente módulo:
Abre el archivo y agrega una flor, recibida como parámetro
manteniendo la política descrita anteriormente
procedure agregarFlor (var a: tArchFlores ; nombre: string;
codigo:integer);
b. Liste el contenido del archivo omitiendo las flores eliminadas. Modifique lo que
considere necesario para obtener el listado.}
program Emanuel;
const
  valorAlto= 9999;
type
  reg_flor = record
    nombre: String[45];
    codigo:integer;
  end;
  tArchFlores= file of reg_flor;
  procedure agregarFlor (var arch: tArchFlores ; nombre: string; codigo:integer);
  var
    reg,actual: reg_flor;
    n: string;
  begin
    writeln('nombre de archivo'); readln(n);
    assign(arch,n); reset(arch);
    read(arch,reg);
    actual.nombre:= nombre; actual.codigo:= codigo;
    if (reg.codigo <> 0) then begin
      seek(arch,(reg.codigo * -1));
      read(arch,reg);
      seek(arch,filePos(arch)-1);
      write(arch,actual);
      seek(arch,0);
      write(arch,reg)
    end
    else begin
      seek(arch,fileSize(arch)-1);
      write(arch,actual);
    end;
    close(arch)
  end;
  procedure leer(var arch: tArchFlores; var reg: reg_flor);
  begin
    if(not eof(arch))then read(arch,reg)
    else reg.codigo := valorAlto
  end;
  procedure listar(var arch: tArchFlores);
  var
    reg: reg_flor;
    n: string;
  begin
    writeln('nombre de archivo'); readln(n);
    assign(arch,n); reset(arch);
    leer(arch,reg);
    while ((reg.codigo <> valorAlto) and (reg.codigo > 0)) do begin
      writeln(reg.nombre);
      writeln(reg.codigo);
      leer(arch,reg)
    end;
    close(arch)
  end;
var
 arch: tArchFlores;
 nombre: string;
 codigo: integer;
begin
  readln(nombre); readln(codigo);
  agregarFlor(arch,nombre,codigo);
  listar(arch)
end.
