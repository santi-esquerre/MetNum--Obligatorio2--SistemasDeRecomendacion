## -*- texinfo -*-
## @node generateRecommendationList
## @deftypefn {Function} {@var{L} =} generateRecommendationList (usuario_id)
## PRE: Existe un usuario con el id usuario_id.
## POST: Se construye la lista de recomendación de películas L para el usuario con el id usuario_id usando filtrado en base a contenidos, es decir, donde se ordenan los id de las películas en orden de preferencia decreciente, además se retorna LRatings, que es el vector de puntajes de las películas, que en la posición i-ésima tiene el puntaje de la película i.
## @end deftypefn
function [L, LRatings] = generateRecommendationList (usuario_id)
    Qu = createMovieGenderMatrix();
    r_u = createUserRatingsMatrix(usuario_id);
    p_u = createTasteVector(usuario_id, Qu, r_u);
    LRatings = Qu * p_u;

    [~, L] = sort(abs(LRatings), 'descend');
end
