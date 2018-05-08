function output = ppn5out(t,y,flag)

%
% PPN5OUT  is the output function for PPN5.

%  Copywright (c)  John C. Polking, Rice University
%  Last Modified: March 3, 1997

ppdisp = findobj(get(0,'child'),'flat','name','PPLANE5 Display'); %gca;   % 
dud = get(ppdisp,'user');
ppdispa = dud.axes;
ud = get(ppdispa,'user');
stop = ud.stop;
gstop = ud.gstop;
col = dud.color.temp;

if (nargin < 3)   
  if stop   
    output = 1;
    ppn5out(1,y,'done');
  else	
    L = length(t);
    if gstop    
      % Update stop.   Are we out of the compute window?
      yl = y(:,L);
      if any([yl;-yl] - ud.cwind < 0);
	stop = 1;
      end  
      
      % If the derivative function is small we assume there is a sink.
      if (ud.i > 10)
	yy = [ud.y,y];
	dyy = yy(:,1:L) - yy(:,2:(L+1));
	DY = ud.DY(:,ones(1,L));
	dyy = dyy./DY;
	MMf = min(sqrt(sum(dyy.^2)));      
	if (MMf<=ud.sinkeps*abs(t(1) - t(L))) 
	  stop = 2; 
	end	
      else
	ud.i = ud.i + 1;
      end
      
      % We look for a maximum in the randomly chosen direction.  If
      % we find one, we compare it with previously found maxima.  If
      % our new one is close to an old one we stop.  If not, we
      % record the position.
      
      rr = ud.R*y;
      
      v = [ud.rr,rr];
      ud.rr = v(:,[L+1,L+2]);    
      [m,ii] = max(v(1,:));
      %ii = ii(1);
      if( 1< min(ii) & max(ii)<L+2 )
	kk=0;
	turn = ud.turn;
	perpeps = ud.perpeps;
	paraeps = ud.paraeps;
	tk = ud.tk;
	while ( (kk<tk) & (~stop) )
	  kk = kk+1;
	  if ((abs(v(1,ii)-turn(1,kk))<perpeps) &...
		(abs(v(2,ii)-turn(2,kk))<paraeps) )
	    stop = 3;
	  end  
	end
	ud.tk = tk + 1;
	if tk >= size(turn,2)
	  ud.turn = [turn,zeros(2,10)];
	end
	ud.turn(:,tk+1) = v(:,ii);
      end
    end      
    output = 0;
    ud.stop = stop;
    yold = ud.y;    
    ud.y = y(:,L);
    set(ppdispa,'user',ud);
    
    % Finally we plot the newest line segment.
    
    set(ud.line,'Xdata',[yold(1),y(1,:)],'Ydata',[yold(2),y(2,:)]);
    drawnow    
  end
  
else
  switch(flag)
    case 'init'                  % ppn5out(tspan,y0,'init')
      ud.y = y(:);
      ud.i = 1;
      
      % Set the the line handle.
      figure(ppdisp);
      ud.line = plot([ud.y(1),ud.y(1)],[ud.y(2),ud.y(2)],...
	  'color',col,'erase','none');
      
      if gstop    
	% Chose a random direction & initialize the search for orbit maxima n
	% that direction.
	
	theta = rand*2*pi;
	ud.R = [cos(theta), sin(theta); -sin(theta),cos(theta)];
	qq = ud.R*y;
	ud.rr = [qq,qq];
	z = ud.DY(1) + sqrt(-1)*ud.DY(2);
	w = exp(i*theta);      
	r = abs(z);
	%      phi1 = theta + angle(z);
	%      phi2 = theta - angle(z);
	%      a1 = r*[cos(phi1),sin(phi1)];
	%      a2 = r*[cos(phi2),sin(phi2)];
	%      a1 = abs(a1);
	%      a2 = abs(a2);
	a1 = w*z;
	a2 = w*(z');
	%      a = max(a1(1),a2(1));
	%      b = max(a1(2),a2(2));
	a = max(abs(real([a1,a2])));
	b = max(abs(imag([a1,a2])));
	ud.perpeps = a/1000;	% We want to be real
	% close in this direction.
	ud.paraeps = b/100;	        % We do not have to be
	% too careful in this direction.
	ud.sinkeps = 0.005/dud.settings.refine;
	ud.tk = 0;
	ud.turn = zeros(2,10);
      end      
      output = 0;
      ud.stop = 0;
      set(ppdispa,'UserData',ud);
      
    case 'done'			% ppn5(t,y,'done');    
      nstr = get(dud.notice,'string');
      if ~isempty(y)
	set(ud.line,'Xdata',[ud.y(1),y(1,:)],'Ydata',[ud.y(2),y(2,:)]);
      end
      switch stop
	case 1
	  nstr{5} = [nstr{5}, ' left the computation window.']; 
	case 2
	  ystr = ['(',num2str(y(1),2), ', ', num2str(y(2),2),').'];
	  nstr{5} = [nstr{5}, ' --> a possible eq. pt. near ',ystr];
	case 3
	  nstr{5} = [nstr{5}, ' --> a nearly closed orbit.'];
	case 4
	  nstr{5} = [nstr{5}, ' was stopped by the user.'];
      end
      set(dud.notice,'string',nstr);
      drawnow
      output = 1;
  end
end
