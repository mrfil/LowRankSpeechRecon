function dim = size(ob)
%function dim = size(ob)
%       "size" method for Gtomo2 class


  time_basis = ob.time_basis;
  ky_ind = ob.ky_ind;
  kz_ind = ob.kz_ind;
  N_tpt = ob.N_tpt;   
  N = ob.N;
  Nz = ob.Nz;
  L = ob.L;
  Nn = size(ky_ind,1);
  
  
  dim = [N*Nn*N_tpt N*N*Nz*L];