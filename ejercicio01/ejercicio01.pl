% --- HECHOS Y CAPACIDADES (PARÁMETROS DEL PROBLEMA) ---

% Coordenadas de las ubicaciones: ubicacion(ID, X, Y).
ubicacion(orilla_inicial, 0.0, 5.0).
ubicacion(piedra1, 2.0, 4.0).
ubicacion(piedra2, 5.0, 6.0).
ubicacion(piedra3, 8.0, 4.0).
ubicacion(piedra4, 5.0, 0.0).
ubicacion(orilla_final, 10.0, 5.0).

% Capacidad de la rana: distancia máxima de salto.
salto_maximo(4.0).

meta(pos(orilla_final)).
     
distancia_euclidiana(X1, Y1, X2, Y2, Distance):-
    Distance is sqrt((X2-X1)**2 + (Y2-Y1)**2).
    
%dfs base
dfs(EstadoActual, _, [EstadoActual]):-
    meta(EstadoActual).

%dfs recursivo
dfs(EstadoActual, Visitados, [EstadoActual | CaminoRestante]):-
    siguiente_estado(EstadoActual, SiguienteEstado),
    not(member(SiguienteEstado, Visitados)),
    dfs(SiguienteEstado, [SiguienteEstado | Visitados], CaminoRestante).
    
%transicion
siguiente_estado(pos(LugarActual), pos(LugarSiguiente)) :-
    ubicacion(LugarActual, X1, Y1),
    ubicacion(LugarSiguiente, X2, Y2),
    distancia_euclidiana(X1, Y1, X2, Y2, D),
    salto_maximo(M),
    D =< M.

buscar_solucion(Solucion) :-
    EstadoInicial = pos(orilla_inicial), 
    dfs(EstadoInicial, [EstadoInicial], Solucion).
