function ob = Masksep(A, mask1, mask2);
% function ob = scaledAC(A, C, scA, scC);
%	Construct scaledAC object, which can do AS*x and AS'y operations

%	default object
ob.A = 0;	% should these be []'s
ob.mask1 = 0;
ob.mask2 = 0;
ob.is.empty	= logical(1);
ob.is.transpose = logical(0);
%ob.version = 1.0;

if nargin == 0
	ob = class(ob, 'Masksep');
	return
end

% if isa(A, 'Masksep')
% 	ob = A;
% 	return
% end

if nargin ~= 3  %7
	help scaledAC
	error nargin
end

	%	fill object
    
	ob.A = A;	% should these be []'s
    ob.L = size(mask1,4);
    ob.mask1 = mask1(:);
    ob.mask2 = mask2(:);
    ob.szA = size(A);
    ob.N = size(mask1(:),1)./ob.L;
    

%     if ~(ob.szA1 == ob.szA2)
%         sprintf('ERROR: first dimension of A1 and A2 should be same.')
%         return
%     end


	ob.is.empty	= logical(0);

%	ob.m = size(we);	% image size
%	ob.n = size(we);

	ob = class(ob, 'Masksep');
