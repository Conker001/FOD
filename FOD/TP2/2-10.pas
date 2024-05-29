{Se tiene información en un archivo de las horas extras realizadas por los empleados de una
empresa en un mes. Para cada empleado se tiene la siguiente información: departamento,
división, número de empleado, categoría y cantidad de horas extras realizadas por el
empleado. Se sabe que el archivo se encuentra ordenado por departamento, luego por
división y, por último, por número de empleado. Presentar en pantalla un listado con el
siguiente formato:
Departamento
División
Número de Empleado Total de Hs. Importe a cobrar
...... .......... .........
...... .......... .........
Total de horas división: ____
Monto total por división: ____
División
.................
Total horas departamento: ____
Monto total departamento: ____
Para obtener el valor de la hora se debe cargar un arreglo desde un archivo de texto al
iniciar el programa con el valor de la hora extra para cada categoría. La categoría varía
de 1 a 15. En el archivo de texto debe haber una línea para cada categoría con el número
de categoría y el valor de la hora, pero el arreglo debe ser de valores de horas, con la
posición del valor coincidente con el número de categoría.}
program Emanuel;
const
  valorAlto= 'zzzz';
  limiteCAT= 15;
type
  empleados = record
    departamento: string;
    division: string;
    empleado: integer;
    categoria: integer;
    horas: real;
  end;
  actual= record
    departamento: string;
    division: string;
    empleado: integer;
  end;
  paraT = record
    indice: integer;
    precio: real;
  end;
  horayP= record
    horas: real;
    monto: real
  end;
  maestro = file of empleados;
  CAT = array[1..limiteCAT] of real;
  procedure cargar(var v:CAT);
  var
  texto: text;
  reg: paraT;
  begin
    assign(texto, 'dir ubi text'); reset(texto);
    while (not eof (texto)) do begin
      readln(texto,reg.indice,reg.precio);
      v[reg.indice]:= reg.precio
    end;
    close(texto)
  end;
  procedure informar(var mae: maestro; var v: CAT);
    procedure leer(var m:maestro; var reg: empleados);
    begin
      if (not eof (m)) then read(m,reg)
      else reg.departamento := valorAlto
    end;
  var
    reg: empleados;
    regactual: actual;
    montoD,montodp,montoactual: horayP;
  begin
    leer(mae,reg);
    while (reg.departamento <> valorAlto) do begin
      regactual.departamento:= reg.departamento;
      montodp.monto:=0; montodp.horas:=0;
      writeln('dpto: ', reg.departamento);
      while(regactual.departamento = reg.departamento) do begin
        regactual.division:= reg.division;
        montoD.monto:= 0; montoD.horas:= 0;
        writeln('division: ',reg.division);
        while ((regactual.departamento = reg.departamento)and(regactual.division = reg.division))do begin
          regactual.empleado:= reg.empleado;
          montoactual.monto:= 0; montoactual.horas:= 0;
          writeln('empleado      ','total de hs.     ','monto a cobrar         ');
          while ((regactual.departamento = reg.departamento)and(regactual.division = reg.division)and(regactual.empleado = reg.empleado))do begin
            montoactual.horas:= montoactual.horas + reg.horas;
            montoactual.monto:= montoactual.monto + (reg.horas*v[reg.categoria]);
            leer(mae,reg)
          end;
          //actual
          writeln(regactual.empleado, montoactual.horas, montoactual.monto);
          montoD.horas:= montoD.horas + montoactual.horas;
          montoD.monto:= montoD.monto + montoactual.monto;
        end;
        //div
        writeln('horas: ',montoD.horas);
        writeln('monto: ',montoD.monto);
        writeln('div: ',regactual.division);
        montodp.horas:= montodp.horas + montoD.horas;
        montodp.monto:= montodp.monto + montoD.monto;
      end;
      //dpto
      writeln('horas: ',montodp.horas);
      writeln('monto: ',montodp.monto)
    end;
    
  end;
var
  vector: CAT;
  mae: maestro;
begin
  cargar(vector);
  assign(mae,'maestro'); reset(mae);
  informar(mae,vector);
  close(mae)
end.
