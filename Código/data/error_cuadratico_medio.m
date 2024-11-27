function error = error_cuadratico_medio(P, Q, puntajes)
    
    n_puntajes  = size(puntajes, 1);   # Cantidad de puntajes
    error = 0;
    
    for p = 1:n_puntajes
        u = puntajes(p,1);  # Usuario que califica
        i = puntajes(p,2);  # Pelicula calificada
        r_ui = puntajes(p, 3);  # Puntaje dado por el usuario
        
        p_u = P(u,:);  # Vector del usuario que califica
        q_i = Q(i,:);  # Vector de la pelicula calificada
        
        error += (p_u*q_i' - r_ui)^2;
    endfor
    
    error /= n_puntajes;
    
endfunction
