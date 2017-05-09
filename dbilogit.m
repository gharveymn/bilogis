function xout=dbilogit(order,xin,bendparam,lo,hi,newlo,newhi)
	% dbilogit
	% derivative of logit, up to order 2
	%
	% param:
	%	order		the order of the derivative (up to order 2)
	%	xin			the points to be transformed
	%	bendparam		parameter governing how much the logistic curve will bend (10 will give an average curve).
	%	lo			(optional) inf of the domain
	%	hi			(optional) sup of the domain
	%	newlo		(optional) inf of the new domain
	%	newhi		(optional) sup of the new domain
	% 
	% usage:
	%	required: order, xin, bendparam
	%	if lo,hi,newlo,newhi are not supplied then transform is done in place
	%	only supplying lo and hi is kinda useless...
	%	if all are supplied then transforms between the domains (you can mirror the distribution by using something
	%	like (order,xin,bendparam,1,0,0,1))
	%
	% Author: Gene Harvey
	
	c_3 = bendparam;
	
	switch nargin
		case 3
			lo = min(xin);
			hi = max(xin);
			newlo = lo;
			newhi = hi;
		case 5
			newlo = lo;
			newhi = hi;
		case 7
			% maybe we should consider using a central error handler...
		otherwise
			error(['Too many or too few arguments. Need either 3, 5, or 7. You entered ' num2str(nargin) '.'])
	end
	
	c_1 = (exp(c_3/2) + 1)/(exp(c_3/2) - 1);
	c_4 = -1/(exp(c_3/2) - 1);
	
	switch order
		case 1
			xout = -(c_1.*(newhi - newlo))./(c_3.*(c_1./(c_4 + (lo - xin)./(hi - lo)) + 1)...
				.*(hi - lo).*(c_4 + (lo - xin)./(hi - lo)).^2);
		case 2
			xout = (c_1.^2*(newhi - newlo))./(c_3.*(c_1./(c_4 + (lo - xin)./(hi - lo)) + 1).^2 ...
				.*(hi - lo).^2.*(c_4 + (lo - xin)./(hi - lo)).^4) ...
				- (2.*c_1.*(newhi - newlo))./(c_3.*(c_1./(c_4 + (lo - xin)./(hi - lo)) + 1)...
				.*(hi - lo).^2.*(c_4 + (lo - xin)./(hi - lo)).^3);
	end
	
