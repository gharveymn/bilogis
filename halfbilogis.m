function xout=halfbilogis(xin,bendparam,lo,hi,newlo,newhi)
	% halfbilogis
	% makes a bijective logistic transform from 0 to 1. That is, f:[0,1]->[0,1] invertible s.t.
	%								/                  c_1              1 \
	%	f(x) = newlo + (2 newhi - 2 newlo) | c_4 + ------------------------- - - |
	%								|          / c_3 (lo - xin) \       2 |
	%								|       exp| -------------- | + 1     |
	%								\          \   2 hi - 2 lo  /         /
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
			%it's cool
		otherwise
			error(['Too many or too few arguments. Need either 2, 4, or 6. You entered ' num2str(nargin) '.'])
	end
	
	c_1 = (exp(c_3/2) + 1)/(exp(c_3/2) - 1);
	c_4 = -1/(exp(c_3/2) - 1);
	
	xout = 2.*(newhi-newlo).*(c_1./(1+exp(-c_3*((xin-lo)/(2*(hi-lo))))) + c_4 - 1/2) + newlo;
	
end

