/*
Họ và tên: Nguyễn Vạn Phúc Huy
Mssv: 23110163
*/

solve(Vx, Vy, Z) :-
    write('Start state: (0, 0)'), nl,
    % mugging với danh sách Visited khởi tạo là [(0,0)]
    (mugging(0, 0, Vx, Vy, Z, [(0,0)]) ->
        true
    ;   write('No solution found (Loop detected or impossible).'), nl).

% stop mugging
mugging(X, Y, _, _, Z, _) :-
    (X =:= Z ; Y =:= Z),
    write('Result: Da dong duoc '), write(Z), write(' lit nuoc.'), nl,
    write('Final state: X='), write(X), write(', Y='), write(Y), nl,
    !. % Dung chuong trinh

% Rule 1: fill Y
mugging(X, 0, Vx, Vy, Z, Visited) :-
    % Check loop: Trạng thái mới sẽ là (X, Vy)
    NewY is Vy,
    \+ member((X, NewY), Visited), % check if node is visited lmao
    % \+  = negative
    write('('), write(X), write(', '), write(NewY), write(')'), nl,
    mugging(X, NewY, Vx, Vy, Z, [(X, NewY) | Visited]).

% Rule 2: empty X
mugging(Vx, Y, Vx, Vy, Z, Visited) :-
    % New state = (0, Y)
    NewX is 0,
    \+ member((NewX, Y), Visited), % check if node is visited lmao
    write('('), write(NewX), write(', '), write(Y), write(')'), nl,
    mugging(NewX, Y, Vx, Vy, Z, [(NewX, Y) | Visited]).

% Rule 3: pour Y -> X
mugging(X, Y, Vx, Vy, Z, Visited) :-
    Y > 0,          % Y dell empty
    X < Vx,         % X not filled to Vx
    
    % Tinh luong nuoc k can do (min(Y, Vx - X))
    K is min(Y, Vx - X),
    
    % Fill X from Y 
    NewX is X + K,
    NewY is Y - K,
    
    % Check loop:
    \+ member((NewX, NewY), Visited), % check if node is visited lmao
    write('('), write(NewX), write(', '), write(NewY), write(')'), nl,
    
    % lặp lại đệ quy mugging , thêm trạng thái mới vào list Visited
    mugging(NewX, NewY, Vx, Vy, Z, [(NewX, NewY) | Visited]).
