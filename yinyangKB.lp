% Tamaño del tablero ( definir con fijas en instance.lp)
cell(X, Y) :- size(N), X = 1..N, Y = 1..N.

% Cada celda solo puede ser o negra o blanca, ni ambas ni ninguna.
{ color(X, Y, b); color(X, Y, w) } = 1 :- cell(X, Y).

% Si una celda está fija en la entrada, se asigna directamente.
color(X, Y, C) :- fixed(X, Y, C).

% Definir vecinos ortogonales
neighbor(X, Y, X+1, Y) :- cell(X, Y), cell(X+1, Y).
neighbor(X, Y, X-1, Y) :- cell(X, Y), cell(X-1, Y).
neighbor(X, Y, X, Y+1) :- cell(X, Y), cell(X, Y+1).
neighbor(X, Y, X, Y-1) :- cell(X, Y), cell(X, Y-1).





% Inicial es una fija de cada color
start_b(X, Y) :- fixed(X, Y, b).
start_w(X, Y) :- fixed(X, Y, w).

% Conectividad para celdas negras
reachable_b(X, Y) :- start_b(X, Y).
reachable_b(X1, Y1) :- reachable_b(X, Y), neighbor(X, Y, X1, Y1), color(X1, Y1, b).

% Conectividad para celdas blancas
reachable_w(X, Y) :- start_w(X, Y).
reachable_w(X1, Y1) :- reachable_w(X, Y), neighbor(X, Y, X1, Y1), color(X1, Y1, w).

% No puede haber celdas inalcanzables desde la inicial
:- color(X, Y, b), not reachable_b(X, Y).
:- color(X, Y, w), not reachable_w(X, Y).



:- color(X, Y, C), color(X+1, Y, C), color(X, Y+1, C), color(X+1, Y+1, C), cell(X, Y), cell(X+1, Y), cell(X, Y+1), cell(X+1, Y+1).


#show color/3.
