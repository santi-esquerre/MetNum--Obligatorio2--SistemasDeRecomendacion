## -*- texinfo -*-
## @node compareResults
## @deftypefn {Function} {@var{err} =} compareResults (user_id)
## PRE: Existe un usuario con el id user_id.
## POST: Se compara la lista de recomendación de películas generada por el sistema de recomendación en base a contenidos con los puntajes disponibles en el dataset de test;
## @end deftypefn
function err = compareResults (user_id, test_data_path)

    if (nargin != 2)
        test_data_path = "../data/puntajes_test.csv";
    end

    [L, LRatings] = generateRecommendationList(user_id);

    test_data = csvread(test_data_path, 1, 0);

    available_ratings = test_data(test_data(:, 1) == user_id, [2, 3]);

    err = norm(LRatings(available_ratings(:, 1)) - available_ratings(:, 2), 2);

endfunction
