## -*- texinfo -*-
## @node createTasteVector
## @deftypefn {Function} {@var{p_u} =} createTasteVector (usuario_id)
## PRE: Existe un usuario con el id usuario_id.
## POST: Se ha construido el vector p_u con los puntajes estimados.
## @end deftypefn
function p_u = createTasteVector (usuario_id, Qu, r_u)
    % Cargar las matrices Q y R
    if (nargin == 1)
        Qu = createMovieGenderMatrix();
        r_u = createUserRatingsMatrix(usuario_id);
    else if (nargin == 2)
        r_u = createUserRatingsMatrix(usuario_id);
    end

    p_u = Qu(r_u(:, 1), :) \ r_u(:, 2);

end
