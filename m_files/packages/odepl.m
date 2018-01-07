function [tout, yout] = odepl(ypfun, t0, tfinal, y0, tol, trace)

%
% The Fehlberg coefficients:
alpha = [1/4  3/8  12/13  1  1/2]';
beta  = [ [    1      0      0     0      0    0]/4
          [    3      9      0     0      0    0]/32
          [ 1932  -7200   7296     0      0    0]/2197
          [ 8341 -32832  29440  -845      0    0]/4104
          [-6080  41040 -28352  9295  -5643    0]/20520 ]';
gamma = [ [902880  0  3953664  3855735  -1371249  277020]/7618050
          [ -2090  0    22528    21970    -15048  -27360]/752400 ]';
pow = 1/5;
if nargin < 5, tol = 1.e-6; end
if nargin < 6, trace = 0; end

% Initialization
t = t0;
hmax = (tfinal - t)/16;
h = hmax/8;
y = y0(:);
f = zeros(length(y),6);
chunk = 128;
tout = zeros(chunk,1);
yout = zeros(chunk,length(y));
k = 1;
tout(k) = t;
yout(k,:) = y.';

if trace
   clc, t, h, y
end

% Detection of the display window

figs = get(0,'children');
dfdisp = 0;
for (figno = 1:length(figs))
        nn = get(figs(figno),'name');
        if (length(nn) > 1)
                if (strcmp(nn,'PLINE Display'))
                        dfdisp = figs(figno);
                        dh = get(dfdisp,'user');
		end
	end
end

% Set the x-limits

xlim = [dh(10),dh(11)];

% The main loop

while (t < tfinal) & (t + h > t)
if (yout(k,1) > xlim(1)) & (yout(k,1) < xlim(2))
   if t + h > tfinal, h = tfinal - t; end

   % Compute the slopes
   temp = feval(ypfun,t,y);
   f(:,1) = temp(:);
   for j = 1:5
      temp = feval(ypfun, t+alpha(j)*h, y+h*f*beta(:,j));
      f(:,j+1) = temp(:);
   end

   % Estimate the error and the acceptable error
   delta = norm(h*f*gamma(:,2),'inf');
   tau = tol*max(norm(y,'inf'),1.0);

   % Update the solution only if the error is acceptable
   if delta <= tau
      t = t + h;
      y = y + h*f*gamma(:,1);
      k = k+1;
      if k > length(tout)
         tout = [tout; zeros(chunk,1)];
         yout = [yout; zeros(chunk,length(y))];
      end
      tout(k) = t;
      yout(k,:) = y.';
   end
   if trace
      home, t, h, y
   end

   % Update the step size
   if delta ~= 0.0
      h = min(hmax, 0.8*h*(tau/delta)^pow);
   end
else
   t = tfinal;
end
end

if (t < tfinal)
   disp('Singularity likely.')
   t
end

tout = tout(1:k);
if (yout(k) <= xlim(1))
   yout = yout(1:k-1,:);
   yout(k) = xlim(1);
elseif (yout(k) >= xlim(2))
   yout = yout(1:k-1,:);
   yout(k) = xlim(2);
else
   yout = yout(1:k,:);
end


