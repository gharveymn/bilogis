function xout=bilogis(xin,bendparam,lo,hi,newlo,newhi)
	% bilogis
	% Makes a bijective logistic transform between any two definite compact subsets of R. That is, f:S->T, S,T \in R
	% s.t.
	%	        e^(c_3/2)-e^(-c_3*(x-1/2))
	% f(x) =  ----------------------------------.
	%     	(e^(c_3/2)-1)*(1+e^(-c_3*(x-1/2)))
	% 
	% param:
	%	xin			the points to be transformed
	%	bendparam		parameter governing how much the logistic curve will bend (10 will give an average curve).
	%	lo			(optional) inf of the domain
	%	hi			(optional) sup of the domain
	%	newlo		(optional) inf of the new domain
	%	newhi		(optional) sup of the new domain
	% 
	% usage:
	%	required: xin, bendparam
	%	if lo,hi,newlo,newhi are not supplied then transform is done in place
	%	only supplying lo and hi is kinda useless...
	%	if all are supplied then transforms between the domains (you can mirror the distribution by using something
	%	like (xin,bendparam,1,0,0,1))
	%
	% Author: Gene Harvey
	
	c_3 = bendparam;
	
	switch nargin
		case 2
			lo = min(xin);
			hi = max(xin);
			newlo = lo;
			newhi = hi;
			
		case 4
			newlo = lo;
			newhi = hi;
		case 6
			% maybe we should consider using a central error handler...
		otherwise
			error(['Too many or too few arguments. Need either 2, 4, or 6. You entered ' num2str(nargin) '.'])
	end
	
	c_1 = (exp(c_3/2) + 1)/(exp(c_3/2) - 1);
	c_4 = -1/(exp(c_3/2) - 1);
	
	xout = (newhi-newlo).*(c_1./(1+exp(-c_3*((xin-lo)/(hi-lo)-1/2))) + c_4) + newlo;
	
end

