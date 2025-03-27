% Tamaño del tablero ( definir con fijas en instance.lp)
cell(X, Y) :- gridsize(N), X = 0..N-1, Y = 0..N-1.

% Cada celda solo puede ser o negra o blanca, ni ambas ni ninguna.
1{ _drawcircle(X, Y, black); _drawcircle(X, Y, white) }1 :- cell(X, Y).


% Definir vecinos ortogonales
neighbor(X, Y, X', Y') :- cell(X, Y), cell(X', Y'), X = X', |Y-Y'| = 1.
neighbor(X, Y, X', Y') :- cell(X, Y), cell(X', Y'), Y = Y', |X-X'| = 1.




% Regla 1: Todas las celdas deben estar otrogonalmente conectadas a todas las celdas de su mismo color

% Inicial es una sola fija de cada color
1{start_b(X, Y) : _drawcircle(X, Y, black)}1.
:- start_b(X, Y), _drawcircle(X1, Y1, black), X1 < X.
:- start_b(X, Y), _drawcircle(X, Y1, black), Y1 < Y.

1 { start_w(X, Y) : _drawcircle(X, Y, white) } 1.
:- start_w(X, Y), _drawcircle(X1, Y1, white), X1 < X.
:- start_w(X, Y), _drawcircle(X, Y1, white), Y1 < Y.

% Conectividad para celdas negras
reachable_b(X, Y) :- start_b(X, Y).
reachable_b(X1, Y1) :- reachable_b(X, Y), neighbor(X, Y, X1, Y1), _drawcircle(X1, Y1, black).

% Conectividad para celdas blancas
reachable_w(X, Y) :- start_w(X, Y).
reachable_w(X1, Y1) :- reachable_w(X, Y), neighbor(X, Y, X1, Y1), _drawcircle(X1, Y1, white).

% No puede haber celdas inalcanzables desde la inicial
:- _drawcircle(X, Y, black), not reachable_b(X, Y).
:- _drawcircle(X, Y, white), not reachable_w(X, Y).



% Regla 2: En espacio 2x2, no pueden ser las cuatro del mismo color
:- _drawcircle(X, Y, C), _drawcircle(X+1, Y, C), _drawcircle(X, Y+1, C), _drawcircle(X+1, Y+1, C), cell(X, Y), cell(X+1, Y), cell(X, Y+1), cell(X+1, Y+1).


% Lema 1: En espacio 2x2, no pueden ser las diagonales del mismo color
:- _drawcircle(X, Y, C), _drawcircle(X+1, Y, C'), _drawcircle(X, Y+1, C'), _drawcircle(X+1, Y+1, C), cell(X, Y), cell(X+1, Y), cell(X, Y+1), cell(X+1, Y+1).



% Lema 2: Pensando solo en las celdas del borde del tablero, todas deben estar conectadas ortogonalmente a el resto de su color

% Definir celdas en el borde
borde(X, Y, C) :- _drawcircle(X, Y, C), gridsize(N), X = 0.
borde(X, Y, C) :- _drawcircle(X, Y, C), gridsize(N), X = N-1.
borde(X, Y, C) :- _drawcircle(X, Y, C), gridsize(N), Y = 0.
borde(X, Y, C) :- _drawcircle(X, Y, C), gridsize(N), Y = N-1.

% Inicial es una sola fija de cada color
1{start_b_borde(X, Y) : borde(X, Y, black)}1.
:- start_b_borde(X, Y), borde(X1, Y1, black), X1 < X.
:- start_b_borde(X, Y), borde(X, Y1, black), Y1 < Y.

1 { start_w_borde(X, Y) : borde(X, Y, white) } 1.
:- start_w_borde(X, Y), borde(X1, Y1, white), X1 < X.
:- start_w_borde(X, Y), borde(X, Y1, white), Y1 < Y.

% Conectividad para celdas negras
reachable_b_borde(X, Y) :- start_b_borde(X, Y).
reachable_b_borde(X1, Y1) :- reachable_b_borde(X, Y), neighbor(X, Y, X1, Y1), borde(X1, Y1, black).

% Conectividad para celdas blancas
reachable_w_borde(X, Y) :- start_w_borde(X, Y).
reachable_w_borde(X1, Y1) :- reachable_w_borde(X, Y), neighbor(X, Y, X1, Y1), borde(X1, Y1, white).

% No puede haber celdas inalcanzables desde la inicial
:- borde(X, Y, black), not reachable_b_borde(X, Y).
:- borde(X, Y, white), not reachable_w_borde(X, Y).

_drawcircle(X, Y, C) :- borde(X, Y, C).



#show _drawcircle/3.