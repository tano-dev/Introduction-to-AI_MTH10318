/*
Họ và tên: Nguyễn Vạn Phúc Huy
Mssv: 23110163
*/

animal(skibidigoat). 
animal(grey_wolf).
animal(rabbit).

goat(skibidigoat).
wolf(grey_wolf).
herbivore(rabbit).

%a
herbivore(X) :- goat(X).
%b
dangerous(X) :- wolf(X).
%c
carnivore(X) :- dangerous(X).
%d
eat(X, meat) :- carnivore(X).
%e
eat(X, grass) :- herbivore(X).
%f
eat(X, Y) :- carnivore(X), herbivore(Y).
%g
drink(X, water) :- carnivore(X) ; herbivore(X).
%h
consume(X, Y) :- animal(X), (eat(X, Y) ; drink(X, Y)).


/*
Cau 2

- Có động vật hung dữ không?
?- dangerous(X).

output: grey_wolf  (Vì ở dòng 7 ta đã định nghĩa grey_wolf là một con sói, và sói là động vật hung dữ ở dòng 17)

- Và nó tiêu thụ cái gì?
?- dangerous(X), consume(X, Y).

output:
X = grey_wolf, Y = meat (vì ở dòng 21)
X = grey_wolf, Y = rabbit (vì ở dòng 25 )
X = grey_wolf, Y = skibidigoat (vì ở dòng 25)
X = grey_wolf, Y = water (vì ở dòng 31 và dòng 27)
 
 
 */