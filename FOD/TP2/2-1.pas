program Emanuel;
const
  valorAlto= 9999;
type
  empleados= record
    codigo: integer;
    nombre: string;
    monto: real;
  end;
  archivos = file of empleados;
  procedure compactar(var archivo: archivos; var compact: archivos);
    procedure leer(var data: archivos; var reg: empleados);
      begin
      if (not eof(data)) then
        read(data, reg)
      else reg.codigo := valorAlto
    end;
  var
    reg,actual: empleados;
  begin
    reset(archivo); rewrite(compact);
    leer(archivo,reg);
    while (reg.codigo <> valorAlto) do begin
      actual:= reg;
      actual.monto:= 0;
      while ((actual.codigo <> valorAlto) and (actual.codigo = reg.codigo)) do begin
        actual.monto:= actual.monto + reg.monto;
      end;
      write(compact,actual);
    end;
    close(archivo); close(compact);
  end;
var
  archivo,compact: archivos;
begin
  assign(archivo, 'comisiones');
  assign(compact, 'C.compacto');
  compactar(archivo,compact);
end.
