{Se cuenta con un archivo que almacena información sobre especies de aves en vía
de extinción, para ello se almacena: código, nombre de la especie, familia de ave,
descripción y zona geográfica. El archivo no está ordenado por ningún criterio. Realice
un programa que elimine especies de aves, para ello se recibe por teclado las
especies a eliminar. Deberá realizar todas las declaraciones necesarias, implementar
todos los procedimientos que requiera y una alternativa para borrar los registros. Para
ello deberá implementar dos procedimientos, uno que marque los registros a borrar y
posteriormente otro procedimiento que compacte el archivo, quitando los registros
marcados. Para quitar los registros se deberá copiar el último registro del archivo en la
posición del registro a borrar y luego eliminar del archivo el último registro de forma tal
de evitar registros duplicados.
Nota: Las bajas deben finalizar al recibir el código 500000}
program Emanuel;
const
  valorAlto= 9999;
  corte = 500000;
type
  aves= record
    codigo: integer;
    nombre: string;
    familia: string;
    descripcion: string;
    zona: string
  end;
  maestro= file of aves;
  procedure leer(var mae: maestro; var reg: aves);
  begin
    if(not eof (mae))then read(mae,reg)
    else reg.codigo:= valorAlto;
  end;
  procedure baja(var mae: maestro);
  var
    reg: aves;
    cod: longInt;
  begin
    writeln('nombre de especie a elim'); readln(cod);
    while (cod <> corte) do begin
      leer(mae,reg);
      while((reg.codigo <> valorAlto)and (reg.codigo <> cod))do
        leer(mae,reg);
      if (reg.codigo = cod) then begin
        reg.codigo:= reg.codigo*-1;
        seek(mae,filePos(mae)-1);
        write(mae,reg)
      end
      else writeln('cod de especie no encontrado');
      seek(mae,0);
      writeln('nombre de especie a elim'); readln(cod);
    end
  end;
  procedure compactar(var mae: maestro);
  var
    reg,ult: aves;
    pos: integer;
  begin
    seek(mae,0);
    leer(mae,reg);
    while(reg.codigo <> valorAlto) do begin
      if (reg.codigo < 0) then begin
        pos:= filePos(mae)-1;
        seek(mae,fileSize(mae)-1);
        read(mae,ult);
        seek(mae,filePos(mae)-1);
        truncate(mae);
        seek(mae,pos);
        write(mae,ult)
      end;
      leer(mae,reg)
    end
  end;
  procedure eliminar(var mae : maestro);
  begin
    assign(mae,''); reset(mae);
    baja(mae);
    compactar(mae);
    close(mae)
  end;
var
  mae: maestro;
begin
  eliminar(mae)
end.
