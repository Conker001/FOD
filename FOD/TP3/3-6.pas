{Una cadena de tiendas de indumentaria posee un archivo maestro no ordenado con
la información correspondiente a las prendas que se encuentran a la venta. De cada
prenda se registra: cod_prenda, descripción, colores, tipo_prenda, stock y
precio_unitario. Ante un eventual cambio de temporada, se deben actualizar las
prendas a la venta. Para ello reciben un archivo conteniendo: cod_prenda de las
prendas que quedarán obsoletas. Deberá implementar un procedimiento que reciba
ambos archivos y realice la baja lógica de las prendas, para ello deberá modificar el
stock de la prenda correspondiente a valor negativo.
Adicionalmente, deberá implementar otro procedimiento que se encargue de
efectivizar las bajas lógicas que se realizaron sobre el archivo maestro con la
información de las prendas a la venta. Para ello se deberá utilizar una estructura
auxiliar (esto es, un archivo nuevo), en el cual se copien únicamente aquellas prendas
que no están marcadas como borradas. Al finalizar este proceso de compactación
del archivo, se deberá renombrar el archivo nuevo con el nombre del archivo maestro
original.}
program emanuel;
const
  valorAlto=9999;
type
  prendas= record
    codigo: integer;
    descripcion: string;
    colores: string;
    tipo: string;
    stock: integer;
    precio: real
  end;
  maestro=  file of prendas;
  detalle= file of integer;
  procedure leer(var det: detalle; var i: integer);
  begin
    if(not eof(det))then read(det,i)
    else i:= valorAlto
  end;
  procedure baja(var mae: maestro; var det: detalle);
  var
    reg: prendas;
    i: integer;
    n: string;
  begin
    writeln('nombre de archivo'); readln(n);
    assign(mae,n); reset(mae);
    writeln('nombre de archivo detalle'); readln();
    assign(det,n); reset(det);
    leer(det,i);
    while(i <> valorAlto) do begin
      read(mae,reg);
      while(reg.codigo <> i) do
        read(mae,reg);
      reg.stock:= reg.stock* -1;
      seek(mae,filePos(mae)-1);
      write(mae,reg);
      leer(det,i)
    end;
    close(mae); close(det)
  end;
  procedure compactar(var mae: maestro; var nuevo: maestro);
    procedure leer(var mae: maestro; var reg: prendas);
    begin
      if(not eof(mae))then read(mae,reg)
      else reg.codigo:= valorAlto;
    end;
  var
    reg: prendas;
    n: string;
  begin
    writeln('nombre de archivo a compactar'); readln(n);
    assign(mae,n); reset(mae);
    assign(nuevo,'nuevo'); rewrite(nuevo);
    leer(mae,reg);
    while(reg.codigo <> valorAlto) do begin
      if(reg.stock >= 0) then
        write(nuevo,reg);
      leer(mae,reg)
    end;
    close(mae);
    rename(nuevo,n); close(nuevo)
  end;
var
  mae,aux: maestro;
  det: detalle;
begin
  baja(mae,det);
  compactar(mae,aux)
end.
