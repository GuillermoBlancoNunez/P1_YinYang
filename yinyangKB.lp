% Tamaño del tablero ( definir con fijas en instance.lp)
cell(X, Y) :- gridsize(N), X = 0..N-1, Y = 0..N-1.

% Cada celda solo puede ser o negra o blanca, ni ambas ni ninguna.
1{ color(X, Y, black); color(X, Y, white) }1 :- cell(X, Y).


% Asignar celdas fijas (definir en instance.lp)
color(X, Y, C) :- _drawcircle(X, Y, C).

% Definir vecinos ortogonales
neighbor(X, Y, X+1, Y) :- cell(X, Y), cell(X+1, Y).
neighbor(X, Y, X-1, Y) :- cell(X, Y), cell(X-1, Y).
neighbor(X, Y, X, Y+1) :- cell(X, Y), cell(X, Y+1).
neighbor(X, Y, X, Y-1) :- cell(X, Y), cell(X, Y-1).





% Inicial es una sola fija de cada color
1{start_b(X, Y) : _drawcircle(X, Y, black)}1.
:- start_b(X, Y), _drawcircle(X1, Y1, black), X1 < X.
:- start_b(X, Y), _drawcircle(X, Y1, black), Y1 < Y.

1 { start_w(X, Y) : _drawcircle(X, Y, white) } 1.
:- start_w(X, Y), _drawcircle(X1, Y1, white), X1 < X.
:- start_w(X, Y), _drawcircle(X, Y1, white), Y1 < Y.

% Conectividad para celdas negras
reachable_b(X, Y) :- start_b(X, Y).
reachable_b(X1, Y1) :- reachable_b(X, Y), neighbor(X, Y, X1, Y1), color(X1, Y1, black).

% Conectividad para celdas blancas
reachable_w(X, Y) :- start_w(X, Y).
reachable_w(X1, Y1) :- reachable_w(X, Y), neighbor(X, Y, X1, Y1), color(X1, Y1, white).

% No puede haber celdas inalcanzables desde la inicial
:- color(X, Y, black), not reachable_b(X, Y).
:- color(X, Y, white), not reachable_w(X, Y).



:- color(X, Y, C), color(X+1, Y, C), color(X, Y+1, C), color(X+1, Y+1, C), cell(X, Y), cell(X+1, Y), cell(X, Y+1), cell(X+1, Y+1).


_drawcircle(X, Y, C) :- color(X, Y, C).
#show _drawcircle/3.
