meta(Estado):- length(Estado, 8).

es_seguro(Fila, Columna, Estado):-
    verificar_no_amenaza(Fila, Columna, Estado, 1).

verificar_no_amenaza(_, _, [], _).
verificar_no_amenaza(F, C, [H | T], Cont):-
    %parte matemtica
    F =\= H,
    abs(F - H) =\= abs(C- Cont),
    NewCont is Cont + 1,
    verificar_no_amenaza(F, C, T, NewCont).

dfs(EstadoActual, _, EstadoActual):-
    meta(EstadoActual).

dfs(EstadoActual, Visitados, SolucionFinal):-
    siguiente_estado(EstadoActual, EstadoSiguiente),
    not(member(EstadoSiguiente, Visitados)),
    dfs(EstadoSiguiente, [EstadoSiguiente | Visitados], SolucionFinal).

siguiente_estado(EstadoActual, EstadoSiguiente):-
    length(EstadoActual, L),
    Columna is L + 1,
    %indice de la lista = columna, numero en la lista = fila
    member(Fila, [1,2,3,4,5,6,7,8]),
    es_seguro(Fila, Columna, EstadoActual),
    append(EstadoActual, [Fila], EstadoSiguiente).
          
solucion(Solucion) :-
    EstadoInicial = [],
    dfs(EstadoInicial, [EstadoInicial], Solucion).
