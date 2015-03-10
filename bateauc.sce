f=500
m=24190
puiss = 44200

A = [0,1;0,-f/m]
B = [0;(puiss/m)]
C = zeros(2,2)
D= zeros(2,1)
Te=1/25

s1 = syslin('c',A,B,C,D)
s1d = dscr(s1,1/25)

ad = s1d('a')
bd = s1d('b')







