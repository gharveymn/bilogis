function xout=halfbilogit(xin,bendparam,lo,hi,newlo,newhi)
	% halfbilogit
	% inverse of halfbilogis
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
			%all good
		otherwise
			error(['Too many or too few arguments. Need either 2, 4, or 6. You entered ' num2str(nargin) '.'])
	end
	
	c_1 = (exp(c_3/2) + 1)/(exp(c_3/2) - 1);
	c_4 = -1/(exp(c_3/2) - 1);
	
	xout = newlo - (log((2.*c_1.*hi - 2.*c_1.*lo)...
		./(hi - 2.*lo + xin - 2.*c_4.*hi + 2.*c_4.*lo) - 1).*(2.*newhi - 2.*newlo))./c_3;
	
end


