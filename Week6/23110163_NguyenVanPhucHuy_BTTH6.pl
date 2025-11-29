/*
Họ và tên: Nguyễn Vạn Phúc Huy
Mssv: 23110163
*/

parent(marry, bill).
parent(tom, bill).
parent(tom, liz).
parent(bill, ann).
parent(bill, sue).
parent(sue, jim).

woman(marry).
man(tom).
man(bill).
woman(liz).
woman(sue).
woman(ann).
man(jim).

child(Y, X):- parent(X, Y).
mother(X, Y):- parent(X, Y), woman(X).
father(X, Y):- parent(X, Y), man(X).
grandparent(X, Z):- parent(X, Y), parent(Y, Z).
sister(X, Y) :- parent(Z, X), parent(Z, Y), woman(X).


/*
Cau 1
a) ?-parent(jim, X).
output: false (tức là jim không có con)
b) ?-parent(X, jim).
output: sue (vì ở dòng 11 parent(sue, jim). )
c) ?-parent(marry, X), parent(X, part).
output: false (vì không có ai là parent của part)
d) ?-parent(marry, X), parent(X, Y), parent(Y, jim).
output: X = bill , Y = sue (ở dòng 6 parent(marry, bill). và dòng 10 parent(bill, sue). và dòng 11 parent(sue, jim). )



Cau 2
a) ?-parent(X,bill)
output: 
tom
marry

b) ?-parent(marry, Y)
output: 
bill

c) ?-grandparent(X,sue)
output:
marry
tom
 
 
 
 
 */