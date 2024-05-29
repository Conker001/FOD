
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
  {Dada la estructura planteada en el ejercicio anterior, implemente el siguiente módulo:
   Abre el archivo y elimina la flor recibida como parámetro manteniendo
   la política descripta anteriormente
   procedure eliminarFlor(var a: tArchFlores; flor:reg_flor);}
  procedure eliminarFlor (var a: tArchFlores; flor:reg_flor);
  var
    reg,ant: reg_flor;
  begin
    assign(a,'flores'); reset(a);
    read(a,ant);
    leer(a,reg);
    while((reg.codigo <> valorAlto) and (reg.codigo <> flor.codigo)) do
      leer(a,reg);
    if(reg.codigo = flor.codigo)then begin
      seek(a, filePos(a)-1);
      reg.codigo:= filePos(a)*-1;
      write(a,ant);
      seek(a,0);
      write(a,reg)
    end
    else writeln('no esta el archivo');
    close(a)
  end;
var
 arch: tArchFlores;
 nombre: string;
 codigo: integer;
 reg: reg_flor;
begin
  readln(nombre); readln(codigo);
  agregarFlor(arch,nombre,codigo);
  listar(arch);
  readln(reg.nombre); readln(reg.codigo);
  eliminarFlor(arch,reg)
end.
