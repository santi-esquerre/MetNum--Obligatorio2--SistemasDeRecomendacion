% -*- functionInfo -*-
% PRE: Existe un usuario con el id user_id.
% POST: Se compara la lista de recomendación de películas generada por el sistema de recomendación en base a contenidos con los puntajes disponibles en el dataset de test y de ajuste;
function [errAjuste, errTest] = compareResults (user_id, test_data_path, ajuste_data_path)

    if (nargin < 3)
        ajuste_data_path = "../data/puntajes_ajuste.csv";
    end

    if (nargin < 2)
        test_data_path = "../data/puntajes_test.csv";
    end

    [L, LRatings] = generateRecommendationList(user_id);

    data_ajuste = csvread(ajuste_data_path, 1, 0);
    test_data = csvread(test_data_path, 1, 0);

    available_ratings_ajuste = data_ajuste(data_ajuste(:, 1) == user_id, [2, 3]);
    available_ratings_test = test_data(test_data(:, 1) == user_id, [2, 3]);

    errAjuste = (norm(LRatings(available_ratings_ajuste(:, 1)) - available_ratings_ajuste(:, 2), 2)^2) / size(available_ratings_ajuste, 1);
    errTest = (norm(LRatings(available_ratings_test(:, 1)) - available_ratings_test(:, 2), 2)^2) / size(available_ratings_test, 1);

endfunction
