## -*- texinfo -*-
## @node alternatingMinimization
## @deftypefn {Function} {@var{[P, Q]} =} alternatingMinimization ()
##
## @end deftypefn
function [P, Q] = alternatingMinimization (path, maxiter, f)

    if (nargin != 3)
        path = "../data/puntajes_ajuste.csv";
        maxiter = 20;
        f = 15;
    end

    addpath("../data");
    data = csvread(path, 1, 0);

    num_pelis = max(data(:, 2));
    num_usuarios = max(data(:, 1));

    P0 = randn(num_usuarios, f);
    Q0 = randn(num_pelis, f);

    P = P0;
    Q = Q0;

    tic;

    for k = 1:maxiter

        for u = 1:num_usuarios
            % Filtrar las filas correspondientes al u-ésimo usuario
            filas_usuario = data((data(:, 1) == u), :);

            % Crear la matriz de duplas (id película y puntaje)
            r_u = filas_usuario(:, 2:3); % Segunda columna: id película, tercera columna: puntaje
            P(u, :) = Q(r_u(:, 1), :) \ r_u(:, 2);
        end

        for i = 1:num_pelis
            % Filtrar las filas correspondientes a la i-ésima película
            filas_pelicula = data((data(:, 2) == i), :);

            % Crear la matriz de duplas (id usuario y puntaje)
            r_i = filas_pelicula(:, [1, 3]); % Primera columna: id usuario, tercera columna: puntaje
            Q(i, :) = P(r_i(:, 1), :) \ r_i(:, 2);
        end

    end

    toc;

    fprintf(' -> Error promedio ajuste = %.3f\n\n', error_cuadratico_medio(P, Q, csvread("../data/puntajes_ajuste.csv", 1, 0)));
    fprintf(' -> Error promedio test   = %.3f\n\n', error_cuadratico_medio(P, Q, csvread("../data/puntajes_test.csv", 1, 0)));

end
