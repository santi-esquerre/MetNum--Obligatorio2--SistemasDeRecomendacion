function [P,Q] = filtrado_colaborativo(puntajes_ajuste, n_factores, Kmax, puntajes_test)
    
    n_usuarios  = max(puntajes_ajuste(:,1));  # Cantidad de usuarios
    n_peliculas = max(puntajes_ajuste(:,2));  # Cantidad de peliculas
    
    #### Inicializar matrices de usuarios (P) y peliculas (Q) ###
    # ...
    #############################################################
    
    # Loop principal
    for k = 1:Kmax
        
        fprintf('### Iteracion %d de %d:\n', k, Kmax)
        
        # Estimamos nuevos p_u
        for u = 1:n_usuarios
            
            ### Implementar aca el calculo de p_u^(k+1) ###
            # p_u = ...
            P(u,:) = p_u;
            ###############################################
            
        endfor
        
        # Estimamos nuevos q_i
        for i = 1:n_peliculas
            
            ### Implementar aca el calculo de q_i^(k+1) ###
            # q_i = ...
            Q(i,:) = q_i;
            ###############################################
            
        endfor
                
        fprintf(' -> Error promedio ajuste = %.3f\n\n', error_cuadratico_medio(P, Q, puntajes_ajuste));
        fprintf(' -> Error promedio test   = %.3f\n\n', error_cuadratico_medio(P, Q, puntajes_test));
        
    endfor
    
endfunction
