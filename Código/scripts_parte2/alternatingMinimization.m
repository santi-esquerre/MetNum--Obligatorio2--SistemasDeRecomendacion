## -*- texinfo -*-
## @node alternatingMinimization
## @deftypefn {Function} {@var{P, Q, errAjuste, errTest} =} alternatingMinimization (path, maxiter, f, saveError)
## PRE: Existen los archivos de datos puntajes_ajuste.csv y puntajes_test.csv.
## POST: Se intenta minimizar el error cuadrático medio de los puntajes calculados a través del método de minimización alternada, efectivo para datos de ajuste, no tanto para test. Se hacen maxiter iteraciones, se usan f factores latentes y saveError es un booleano que indica si se guardan los errores en cada iteración.
## @end deftypefn
function [P, Q, errAjuste, errTest] = alternatingMinimization(path, maxiter, f, saveError)
    % Verificación de argumentos
    if (nargin < 4)
        saveError = 0;
    end

    if (nargin < 3)
        f = 15;
    end

    if (nargin < 2)
        maxiter = 50;
    end

    if (nargin < 1)
        path = "../data/puntajes_ajuste.csv";
    end

    % Carga el conjunto de datos
    addpath("../data");
    data = csvread(path, 1, 0);
    data_test = csvread("../data/puntajes_test.csv", 1, 0);

    % Definir número de usuarios y películas
    num_pelis = max(data(:, 2));
    num_usuarios = max(data(:, 1));

    % Inicialización aleatoria de las matrices P y Q
    P = 0.2 * randn(num_usuarios, f);
    Q = 0.2 * randn(num_pelis, f);

    % Inicialización de vectores de error
    errAjuste = zeros(maxiter, 1);
    errTest = zeros(maxiter, 1);

    % Preprocesar índices de usuarios y películas
    indices_usuarios = cell(num_usuarios, 1);
    indices_peliculas = cell(num_pelis, 1);

    for u = 1:num_usuarios
        indices_usuarios{u} = find(data(:, 1) == u);
    end

    for i = 1:num_pelis
        indices_peliculas{i} = find(data(:, 2) == i);
    end

    % Iteraciones de minimización alternada
    for k = 1:maxiter
        % Actualización de P
        for u = 1:num_usuarios
            filas_usuario = data(indices_usuarios{u}, :);
            r_u = filas_usuario(:, 2:3); % id película y puntaje
            Q_u = Q(r_u(:, 1), :); % Subconjunto de Q
            P(u, :) = Q_u \ r_u(:, 2); % Resolver sistema
        end

        % Actualización de Q
        for i = 1:num_pelis
            filas_pelicula = data(indices_peliculas{i}, :);
            r_i = filas_pelicula(:, [1, 3]); % id usuario y puntaje
            P_i = P(r_i(:, 1), :); % Subconjunto de P
            Q(i, :) = P_i \ r_i(:, 2); % Resolver sistema
        end

        if (saveError)
            errAjuste(k) = error_cuadratico_medio(P, Q, data);
            errTest(k) = error_cuadratico_medio(P, Q, data_test);
        end

    end

end
