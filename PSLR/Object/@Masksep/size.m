function dim = size(ob)
%function dim = size(ob)
%       "size" method for Gtomo2 class

szA = ob.szA;
L = ob.L;

N = ob.N;

dim = [szA(1) N * L];