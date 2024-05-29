program emanuel;
const
  valorAlto= 9999;
type
  alumnos= record
    codigo: integer;
    nombre: string;
    apellido: string;
    MAprobadas: integer;
    MDesaprobadas: integer
  end;
  materias= record
    codigo: integer;
    aprobo: boolean;
  end;
  maestro = file of alumnos;
  detalle = file of materias;
  procedure actualizar(var maestro: maestro; var detalle: detalle);
    procedure leer(var det: detalle; var reg: materias);
    begin
      if (not eof(det)) then read(det, reg)
      else reg.codigo:= valorAlto;
    end;
    
    procedure Bmaterias(var det: detalle; var reg: materias; var regm: alumnos);
    begin
      while ((reg.codigo <> valorAlto) and (regm.codigo = reg.codigo)) do begin
        if (reg.aprobo) then begin
          regm.MAprobadas:= regm.MAprobadas +1;
          regm.MDesaprobadas:= regm.MDesaprobadas -1
          end
        else regm.MDesaprobadas:= regm.MDesaprobadas +1;
        leer(det,reg);
      end
    end;
  var
    reg: materias; regm: alumnos;
  begin
    reset(maestro); reset(detalle);
    leer(detalle, reg);
    while (reg.codigo <> valorAlto) do begin
      read(maestro,regm);
      while(regm.codigo <> reg.codigo) do begin
        read(maestro, regm)
      end;
      Bmaterias(detalle,reg,regm);
      seek(maestro, filePos(maestro)-1);
      write(maestro, regm)
    end;
    close(maestro); close(detalle)
  end;
  procedure listar(var MAlumnos: maestro);
    procedure leer(var data: maestro; var reg: alumnos);
    begin
      if (not eof(data)) then read(data,reg)
      else reg.codigo:= valorAlto
    end;
  var
    texto: text;
    reg: alumnos;
  begin
    assign(texto, 'text.txt');
    reset(MAlumnos); rewrite(texto);
    leer(MAlumnos,reg);
    while (reg.codigo <> valorAlto) do begin
      if (reg.MAprobadas > reg.MDesaprobadas) then 
        writeln(texto, reg.codigo,'',reg.nombre,'',reg.apellido,'',reg.MAprobadas,'',reg.MDesaprobadas);
      leer(MAlumnos,reg)
    end;
    close(MAlumnos); close(texto)
  end;
  
var
  MAlumnos: maestro; DMaterias: detalle;
begin
  assign(MAlumnos,'maestro'); assign(DMaterias, 'detalle'); 
  actualizar(MAlumnos,DMaterias);
  listar(MAlumnos)
end.
