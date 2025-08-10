% exConcatenateVectors_SCRIPT.m

a = [1 2];
b = [3 4];

c = [ 5; ...
      6 ];

D = [ a ; ...
      b  ]

E = [D c ]
% equivalent expression:
% E_equiv = [ [ a ; b] c]

F = [ [E E]; [a b a]]
% equivalent expression ? 

save ExConcatenateMatrices a b c D E F 
% refer to the save command documentation
