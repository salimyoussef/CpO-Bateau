//Commande en boucle ouverte du bateau
f=2000
m=24190
puiss = 44200/3

A = [0,1;0,-f/m]
B = [0;(puiss/m)]
C = zeros(2,2)
D= zeros(2,1)
Te=1/25
h =1500

s1 = syslin('c',A,B,C,D)
s1d = dscr(s1,1/25)

xh =[678;0]
x0 =[0;0]

ad = s1d('a')
bd = s1d('b')

G = bd
for k=1:h-1
    G=[(ad^k)*bd,G];
end

rang=rank(G)

y = xh-(ad^h)*x0

Gt =G'; //Transformée
u = Gt*inv(G*Gt)*y
// p6 
max(abs(u))

fileid='com.txt'
fp=mopen('/home/sy306571/CpO/bateau/'+fileid,'w');
Kt=u';
Ks=string(u(1));
for k=2:length(u),
Ks=Ks+','+string(u(k));
end
mputstr(Ks,fp);
mclose(fp);

