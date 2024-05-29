{Se cuenta con un archivo de productos de una cadena de venta de alimentos congelados.
De cada producto se almacena: código del producto, nombre, descripción, stock disponible,
stock mínimo y precio del producto.
Se recibe diariamente un archivo detalle de cada una de las 30 sucursales de la cadena. Se
debe realizar el procedimiento que recibe los 30 detalles y actualiza el stock del archivo
maestro. La información que se recibe en los detalles es: código de producto y cantidad
vendida. Además, se deberá informar en un archivo de texto: nombre de producto,
descripción, stock disponible y precio de aquellos productos que tengan stock disponible por
debajo del stock mínimo. Pensar alternativas sobre realizar el informe en el mismo
procedimiento de actualización, o realizarlo en un procedimiento separado (analizar
ventajas/desventajas en cada caso).
Nota: todos los archivos se encuentran ordenados por código de productos. En cada detalle
puede venir 0 o N registros de un determinado producto}
program emanuel;
const
  valorAlto= 9999;
type
  productos= record
    codigo: integer;
    nombre: string;
    descripcion: string;
    stock: integer;
    minStock: integer;
    precio: real
  end;
  ventas= record
    codigo: integer;
    vendidas: integer
  end;
  maestro= file of productos;
  detalle= file of ventas;
  arrayD= array[1..30] of detalle;
  arrayV= array[1..30] of ventas;
  procedure iniciar(var mae: maestro; var det: arrayD);
  var
    i: integer;
  begin
    assign(mae,'maestro'); reset(mae);
    for i:= 1 to 30 do begin
      assign(det[i],'');
      reset(det[i])
    end
  end;
  procedure actualizar(var mae: maestro; var det: arrayD);
    procedure cerrar(var texto:text; var mae: maestro; var deet: arrayD);
    var
      i: integer;
    begin
      close(mae); close(texto);
      for i:= 1 to 30 do
        close(det[i]);
    end;
    procedure leer(var det: detalle; var reg: ventas);
    begin
      if (not eof (det)) then read(det,reg)
      else reg.codigo:= valorAlto
    end;
    procedure leo(var det: arrayD; var reg: arrayV);
    var
      i: integer;
    begin
      for i:= 1 to 30 do begin
        leer(det[i],reg[i])
      end
    end;
    procedure minimo(var min: ventas; var det:arrayD; var reg:arrayV);
    var
      i,save:integer;
    begin
      min.codigo:= valorAlto; save := 0;
      for i:= 1 to 30 do begin
        if (reg[i].codigo < min.codigo) then begin
          min:= reg[i];
          save:= i;
        end
      end;
      if (min.codigo <> valorAlto) then 
        leer(det[save],reg[save])
    end;
    procedure crearTexto(var texto:text; regm: productos);
    begin
      if (regm.stock < regm.minStock) then
        writeln(texto,regm.nombre,'',regm.descripcion,'',regm.stock,'',regm.precio);
    end;
  var
    texto: text;
    reg: arrayV;
    min: ventas;
    regm: productos;
  begin
    assign(texto,'texto'); rewrite(texto);
    leo(det,reg);
    minimo(min,det,reg);
    while (min.codigo <> valorAlto) do begin
      read(mae,regm);
      while(regm.codigo <> min.codigo) do
        read(mae, regm);
      while ((min.codigo <> valorAlto) and (min.codigo = regm.codigo)) do begin
        regm.stock:= regm.stock - min.vendidas;
        minimo(min,det,reg)
      end;
      crearTexto(texto,regm);
      seek(mae, filePos(mae)-1);
      write(mae,regm)
    end;
    cerrar(texto,mae,det);
  end;
var
  mae: maestro;
  det: arrayD;
begin
  iniciar(mae,det);
  actualizar(mae,det)
end.
