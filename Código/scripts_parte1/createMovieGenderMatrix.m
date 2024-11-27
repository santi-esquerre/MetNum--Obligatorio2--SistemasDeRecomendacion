## -*- texinfo -*-
## @node createMovieGenderMatrix
## @deftypefn {Function} {@var{Qu} =} createMovieGenderMatrix (path)
##  PRE:  Existe un archivo CSV en path con la matriz Q, cuyas fila i-ésima es un vector qi de 0’s y 1’s donde en la posición k ponemos 1 si dicha pelı́cula es del género k, y 0 en caso contrario.
##  POST: Se ha construido la matriz Q con las filas del csv, en formato sparse.
## @end deftypefn
function Qu = createMovieGenderMatrix (path)

    if (nargin != 1)
        path = '../data/clasificacion_peliculas.csv';
    end

    % Leer el archivo
    data = csvread(path, 1, 1); % Saltar la cabecera

    % Extraer las dimensiones
    num_peliculas = size(data, 1); % Número de filas (películas)
    num_generos = size(data, 2); % Número de géneros (sin la columna de ID)

    % Extraer las posiciones de los valores no nulos (1s)
    [row_indices, col_indices] = find(data == 1);

    % Crear la matriz sparse
    Qu = sparse(row_indices, col_indices, 1, num_peliculas, num_generos);

    % Verificar el resultado
    % disp(Qu);
end
