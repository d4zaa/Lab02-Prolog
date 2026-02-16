power_list([
    power(logica, 100, 10),
    power(sigilo, 150, 30),
    power(fuerza, 250, 50)
]).
villain_list([
    villain(riddler, 90, [logica, sigilo]),
    villain(bane, 240, [fuerza])
]).

usar_poder(power_list, Power, EnergiaMaxima):-
    power(Power, _, Cost),
    EnergiaMaxima is EnergiaMaxima - Cost.

%dfs base
dfs(EstadoActual, _, [EstadoActual]):-
    meta(EstadoActual).
%dfs recursivo
dfs(EstadoActual, Visitados, [EstadoActual | CaminoRestante]):-
    siguiente_estado(EstadoActual, EstadoSiguiente),
    not(member(EstadoSiguiente, Visitados)),
    dfs(SiguienteEstado, [SiguienteEstado | Visitados], CaminoRestante).

siguiente_estado(estado([villian(_,Vida, Debilidades) | VillanosRestantes],[power(Name, Damage, Cost)| PoderesRestantes],EnergiaInicial), 
                 estado(VillanosRestantes, PoderesRestantes, NuevaEnergia)):-
    EnergiaIniial >= Cost,
    
    
siguiente_estado()

batman_can_win(EnergiaMaxima):-
    power_list(Superpoderes),
    villain_list(Villanos),
    % El estado inicial contiene todos los villanos, todos los poderes y la energía máxima.
    EstadoInicial = estado(Villanos, Superpoderes, EnergiaMaxima),
    dfs(EstadoInicial, [EstadoInicial]). %dfs(Estado,Visitados)
