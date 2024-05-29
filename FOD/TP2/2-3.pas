{El encargado de ventas de un negocio de productos de limpieza desea administrar el stock
de los productos que vende. Para ello, genera un archivo maestro donde figuran todos los
productos que comercializa. De cada producto se maneja la siguiente información: código de
producto, nombre comercial, precio de venta, stock actual y stock mínimo. Diariamente se
genera un archivo detalle donde se registran todas las ventas de productos realizadas. De
cada venta se registran: código de producto y cantidad de unidades vendidas. Se pide
realizar un programa con opciones para:
* 
a. Actualizar el archivo maestro con el archivo detalle, sabiendo que:
● Ambos archivos están ordenados por código de producto.
* 
● Cada registro del maestro puede ser actualizado por 0, 1 ó más registros del
archivo detalle.
* 
● El archivo detalle sólo contiene registros que están en el archivo maestro.
b. Listar en un archivo de texto llamado “stock_minimo.txt” aquellos productos cuyo
stock actual esté por debajo del stock mínimo permitido}
program Emanuel;
const
  valorAlto= 9999;
type
  productos= record
    codigo: integer;
    nombre: string;
    precio: real;
    stock: integer;
    minimoStock: integer
  end;
  ventas= record
    codigo: integer;
    cantidad: integer
  end;
  maestro =  file of productos;
  detalle= file of ventas;
  {a. Actualizar el archivo maestro con el archivo detalle, sabiendo que:
  ● Ambos archivos están ordenados por código de producto.
  ● Cada registro del maestro puede ser actualizado por 0, 1 ó más registros del
  archivo detalle.
  ● El archivo detalle sólo contiene registros que están en el archivo maestro.}
  procedure actualizar(var mae: maestro; var det: detalle);
  procedure leer(var detalle: detalle; var reg: ventas);
  begin
    if(not eof(detalle))then read(detalle,reg)
    else reg.codigo:= valorAlto
  end;
  var
    regm: productos;
    reg: ventas;
  begin
    reset(mae); reset(det);
    leer(det,reg);
    while (reg.codigo <> valorAlto) do begin
      read(mae,regm);
      while (reg.codigo <> regm.codigo) do
        read(mae, regm);
      while((reg.codigo <> valorAlto) and (regm.codigo = reg.codigo))do begin
        regm.stock:= regm.stock - reg.cantidad;
        leer(det,reg)
      end;
      seek(mae,filePos(mae)-1);
      write(mae,regm)
    end;
    close(mae); close(det)
  end;
  {b. Listar en un archivo de texto llamado “stock_minimo.txt” aquellos productos cuyo
  stock actual esté por debajo del stock mínimo permitido}
  procedure listar(var prod: maestro);
    procedure leer(var m: maestro; var reg: productos);
    begin
      if (not eof(m)) then read(m,reg)
      else reg.codigo:= valorAlto
    end;
  var
    texto: text;
    reg: productos;
  begin
    assign(texto,'texto.txt');
    reset(prod); rewrite(texto);
    leer(prod,reg);
    while(reg.codigo <> valorAlto) do begin
      if (reg.stock < reg.minimoStock) then 
        writeln(texto,reg.codigo,'',reg.nombre,'',reg.precio,'',reg.stock,'',reg.minimoStock);
      leer(prod,reg)
    end;
    close(prod); close(texto)
  end;
var
  prod: maestro;
  venta: detalle;
begin
  assign(prod,'maestro'); assign(venta,'detalle');
  actualizar(prod,venta);
  listar(prod);
end.
