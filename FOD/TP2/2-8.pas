{Se cuenta con un archivo que posee información de las ventas que realiza una empresa a
los diferentes clientes. Se necesita obtener un reporte con las ventas organizadas por
cliente. Para ello, se deberá informar por pantalla: los datos personales del cliente, el total
mensual (mes por mes cuánto compró) y finalmente el monto total comprado en el año por el
cliente. Además, al finalizar el reporte, se debe informar el monto total de ventas obtenido
por la empresa.
El formato del archivo maestro está dado por: cliente (cod cliente, nombre y apellido), año,
mes, día y monto de la venta. El orden del archivo está dado por: cod cliente, año y mes.
Nota: tenga en cuenta que puede haber meses en los que los clientes no realizaron
compras. No es necesario que informe tales meses en el reporte.}
program Emanuel;
const
  valorAlto=9999;
type
  cliente = record
    codigo: integer;
    nombre: string;
    apellido: string
  end;
  ventas= record
    cliente: cliente;
    ano: integer;
    mes: integer;
    dia: integer;
    monto: real;
  end;
  actual= record
    codigo: integer;
    ano: integer;
    mes: integer;
  end;
  maestro= file of ventas;
  procedure leer(var mae: maestro; var reg: ventas);
  begin
    if(not eof(mae))then read(mae,reg)
    else reg.cliente.codigo:= valorAlto
  end;
  procedure informar(c: cliente; monto: real);
  begin
    writeln(c.codigo,c.nombre,c.apellido,monto)
  end;
  procedure informar(var mae: maestro);
  var
    regm: ventas;
    cod: actual;
    total,anual,mensual:real;
  begin
    leer(mae,regm); total:= 0;
    while (regm.cliente.codigo <> valorAlto)do begin
      cod.codigo:= regm.cliente.codigo;
      while (regm.cliente.codigo = cod.codigo) do begin
        cod.ano:= regm.ano;
        anual:=0;
        while ((regm.cliente.codigo = cod.codigo)and (cod.ano = regm.ano))do begin
          cod.mes:= regm.mes;
          mensual:=0;
          while ((regm.cliente.codigo = cod.codigo)and (cod.ano = regm.ano)and(cod.mes = regm.mes)) do begin
            mensual:= mensual+ regm.monto;
            leer(mae,regm)
          end;
          anual:= anual+ mensual;
          if (mensual <> 0) then
            informar(regm.cliente,mensual)
        end;
        total:= total+ anual;
        if (anual <> 0) then
          informar(regm.cliente,anual)
      end
    end;
    writeln('total: ',total)
  end;
var
  mae: maestro;
begin
  assign(mae,'maestro'); reset(mae);
  informar(mae);
  close(mae)
end.
