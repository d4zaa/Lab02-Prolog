power_list([
    power(logica, 100, 10),
    power(sigilo, 150, 30),
    power(fuerza, 250, 50)
]).
villain_list([
    villain(riddler, 90, [logica, sigilo]),
    villain(bane, 240, [fuerza])
]).

meta(estado([], _, _)).

usar_poder(power(_, _, Cost), EnergiaMaxima, EnergiaRestante):-
    EnergiaRestante is EnergiaMaxima - Cost.

%dfs base
dfs(EstadoActual, _, [EstadoActual]):-
    meta(EstadoActual), !.
%dfs recursivo
dfs(EstadoActual, Visitados, [EstadoActual | CaminoRestante]):-
    siguiente_estado(EstadoActual, EstadoSiguiente),
    not(member(EstadoSiguiente, Visitados)),
    dfs(EstadoSiguiente, [EstadoSiguiente | Visitados], CaminoRestante).

siguiente_estado(
		estado([villain(_,Vida, Debilidades) | VillanosRestantes], Poderes, EnergiaInicial), 
		estado(VillanosRestantes, PoderesRestantes, NuevaEnergia)):-
    member(power(Name, Damage, Cost), Poderes),
    EnergiaInicial >= Cost,
    Damage >= Vida,
    member(Name, Debilidades),
    select(power(Name, Damage, Cost), Poderes, PoderesRestantes),
    usar_poder(power(Name, Damage, Cost), EnergiaInicial, NuevaEnergia).

batman_can_win(EnergiaMaxima):-
    power_list(Superpoderes),
    villain_list(Villanos),
    % El estado inicial contiene todos los villanos, todos los poderes y la energía máxima.
    EstadoInicial = estado(Villanos, Superpoderes, EnergiaMaxima),
    dfs(EstadoInicial, [EstadoInicial], _). %dfs(Estado,Visitados)
