f=0.1
m=1000000
puiss = 100

A = [0,1;0,-f/m]
B = [0;(puiss/m)]
C = zeros(2,2)
D= zeros(2,1)
Te=1/25

s1 = syslin('c',A,B,C,D)
s1d = dscr(s1,1/25)







