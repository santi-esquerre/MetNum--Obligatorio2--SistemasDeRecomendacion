## -*- texinfo -*-
## @node createUserRatingsMatrix
## @deftypefn {Function} {@var{ru} =} createUserRatingsMatrix (usuario_id, path)
##  PRE:  Existe un archivo CSV en path con las ternas (usuario_Id, pelicula_Id, puntaje) y un usario con la id usuario_id.
##  POST: Se construye la matriz de duplas (id película y puntaje) para un usuario.
## @end deftypefn
function r_u = createUserRatingsMatrix(usuario_id, path)

    if (nargin == 1)
        path = '../data/puntajes_ajuste.csv';
    end

    % Leer los datos del archivo
    data = csvread(path, 1, 0);

    % Filtrar las filas correspondientes al usuario_id
    filas_usuario = data((data(:, 1) == usuario_id), :);

    % Crear la matriz de duplas (id película y puntaje)
    r_u = filas_usuario(:, 2:3); % Segunda columna: id película, tercera columna: puntaje
end
