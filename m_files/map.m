function output = map(action,input1,input2,input3)

if nargin <1
	action ='initialize';
end


if strcmp(action,'initialize')

	% First we make sure that there is no other copy of MAP
	% running, since this causes problems.

	figs = get(0,'children');
	for (figno = 1:length(figs))
		nn = get(figs(figno),'name');
		if (length(nn) >1)
			if (findstr(nn,'MAP')~=[])
				error('Only one copy of MAP can be open at one time.')
			end
		end
	end

	% Initiate several parameters.

	c  = 0;
	v1 = 0;
	v2 = 0;
	rs = 0;
	ax = 2.0;
	colo = 1;

	settings = [c,v1,v2,rs,ax,colo];

	Matrix=[0 1 -1  0];
	Object = 0;

	% Build the Setup window.
	
	texth =20;   		% Height of text boxes.
	varw = 80;		% Length of variable boxes.
	equalw =30;		% Length of equals.
	eqlength = 300;		% Length of right hand sides.
	left =10;		% Left margin.
	
	separation = texth+3;	% Separation between boxes.
	equationbot = 7.5*separation;;
	eqlabelbot = equationbot + 2.5*separation;
	xbot = equationbot + 1.5*separation;	
	tbot = equationbot;		
	
	defigwidth =2*left + varw+equalw+eqlength;	% Width of the figure.
	defigureheight = 8*separation;			% Height of the figure.
	defigurebot = 20;				% Bottom of the figure.
	
	dfset = figure('pos',[20 defigurebot defigwidth defigureheight],...
		'resize','off','name','MAP Setup','numb','off');
	figure(dfset)

	lablen =160;
	
	eqlableft = (defigwidth-lablen)/2;
	
	winstrlen = (defigwidth - 2*left)/2 -120;
	winbot = 2*separation;
	winleft = left+(winstrlen +50 -120)/2;
	wframe=[left+45,winbot+separation-5,...
		defigwidth-2*left-100,3.5*separation+10];
		
        w1 = [
	'sh = get(gcf,''user'');'...
	'wind =sh(3:11);'...
	'sh(15)=str2num(get(wind(3),''string''));'...
	'set(gcf,''user'',sh);'];
	
	w2 = [
	'sh = get(gcf,''user'');'...
	'wind =sh(3:11);'...
	'sh(16)=str2num(get(wind(5),''string''));'...
	'set(gcf,''user'',sh);'];
	
	w3 = [
	'sh = get(gcf,''user'');'...
	'wind =sh(3:11);'...
	'sh(17)=str2num(get(wind(7),''string''));'...
	'set(gcf,''user'',sh);'];

	w4 = [
	'sh = get(gcf,''user'');'...
	'wind =sh(3:11);'...
	'sh(18)=str2num(get(wind(9),''string''));'...
	'set(gcf,''user'',sh);'];

	frame(2) = uicontrol('style','frame','pos',wframe);
	
	wind(1)=uicontrol('style','text',...
		'pos',[left+100 winbot+3*separation defigwidth-200 - 2*left texth],...
		'horizon','center','string','Definition of the matrix');
		
	wind(2) = uicontrol('style','text',...
		'pos',[left+50 winbot+2*separation winstrlen texth],...
		'horizon','right','string',['A11 = ']);

	wind(3) = uicontrol('style','edit',...
		'pos',[left+50+winstrlen winbot+2*separation 50 texth],...
		'string',num2str(Matrix(1)),...
		'call',w1);
	
	wind(4) = uicontrol('style','text',...
		'pos',[left+50 winbot+separation winstrlen texth],...
		'horizon','right','string',['A21 = ']);
	
	wind(5) = uicontrol('style','edit',...
		'pos',[left+50+winstrlen winbot+separation 50 texth],...
		'string',num2str(Matrix(2)),...
		'call',w2);
		
	wind(6) = uicontrol('style','text',...
		'pos',[left+winstrlen+100 winbot+2*separation winstrlen texth],...
		'horizon','right','string',['A12 = ']);

	wind(7) = uicontrol('style','edit',...
		'pos',[left+2*winstrlen+100 winbot+2*separation 50 texth],...
		'string',num2str(Matrix(3)),...
		'call',w3);
	
	wind(8) = uicontrol('style','text',...
		'pos',[left+winstrlen+100 winbot+separation winstrlen texth],...
		'horizon','right','string',['A22 = ']);
		
	wind(9) = uicontrol('style','edit',...
		'pos',[left+2*winstrlen+100 winbot+separation 50 texth],...
		'string',num2str(Matrix(4)),...
		'call',w4);
		
	butt(1) = uicontrol('style','push',...
		'pos',[(defigwidth/4-35),separation,70,texth],...
		'string','Quit','call','map(''quit'')');
	
	butt(2) = uicontrol('style','push',...
		'pos',[(defigwidth/2-35),separation,70,texth],...
		'string','Revert','call','map(''revert'')','visible','off');
		
	butt(3) = uicontrol('style','push',...
		'pos',[(3*defigwidth/4-35),separation,70,texth],...
		'string','Proceed','call','map(''proceed'')');
		
        menug = uimenu('label','Gallery');

        menurot1  = uimenu(menug,'label','Default',...
                 'call','map(''gallery'',1)');

        menurot2  = uimenu(menug,'label','Contracting rotation',...
                 'call','map(''gallery'',2)');

        menurot3  = uimenu(menug,'label','Expanding rotation',...
                 'call','map(''gallery'',3)');

        menueig1  = uimenu(menug,'label','Real eigenvalues',...
                 'call','map(''gallery'',4)');


% Record the handles in the User Data of the Set Up figure.
		
	sh = [frame,wind,butt,Matrix,Matrix,Object,settings];
	set(gcf,'user',sh);
	Matrix = sh(19:22);
	
% Record the important information in the User Data of
% various controls.  

	set(sh(3),'user',0);
		
elseif strcmp(action,'gallery')

        sh = get(gcf,'user');
        frame=sh(1:2);
        wind =sh(3:11);
        sm = get(sh(2),'user');

        set(sh(1),'user',sm);

	if (input1 == 1)
                Matrix = [0,1,-1,0];

                set(wind(2),'string',['A11 = ']);
                set(wind(4),'string',['A21 = ']);
                set(wind(6),'string',['A12 = ']);
                set(wind(8),'string',['A22 = ']);
                set(wind(3),'string',num2str(Matrix(1)));
                set(wind(5),'string',num2str(Matrix(2)));
                set(wind(7),'string',num2str(Matrix(3)));
                set(wind(9),'string',num2str(Matrix(4)));
                sh(15:18) = Matrix;
                set(gcf,'user',sh);

                map('display')

	elseif (input1 == 2)
		Matrix = [0.3,0.8,-0.8,0.3];

        	set(wind(2),'string',['A11 = ']);
        	set(wind(4),'string',['A21 = ']);
        	set(wind(6),'string',['A12 = ']);
        	set(wind(8),'string',['A22 = ']);
        	set(wind(3),'string',num2str(Matrix(1)));
        	set(wind(5),'string',num2str(Matrix(2)));
        	set(wind(7),'string',num2str(Matrix(3)));
        	set(wind(9),'string',num2str(Matrix(4)));
        	sh(15:18) = Matrix;
        	set(gcf,'user',sh);
	
		map('display')

	elseif (input1 == 3)
                Matrix = [0.9,0.7,-0.7,0.9];

                set(wind(2),'string',['A11 = ']);
                set(wind(4),'string',['A21 = ']);
                set(wind(6),'string',['A12 = ']);
                set(wind(8),'string',['A22 = ']);
                set(wind(3),'string',num2str(Matrix(1)));
                set(wind(5),'string',num2str(Matrix(2)));
                set(wind(7),'string',num2str(Matrix(3)));
                set(wind(9),'string',num2str(Matrix(4)));
                sh(15:18) = Matrix;
                set(gcf,'user',sh);

                map('display')

        elseif (input1 == 4)
                Matrix = [0.2,-1.8,-1.2,0.8];

                set(wind(2),'string',['A11 = ']);
                set(wind(4),'string',['A21 = ']);
                set(wind(6),'string',['A12 = ']);
                set(wind(8),'string',['A22 = ']);
                set(wind(3),'string',num2str(Matrix(1)));
                set(wind(5),'string',num2str(Matrix(2)));
                set(wind(7),'string',num2str(Matrix(3)));
                set(wind(9),'string',num2str(Matrix(4)));
                sh(15:18) = Matrix;
                set(gcf,'user',sh);

                map('display')

	end


elseif strcmp(action,'proceed')

% Proceed connects Setup with the Display window.

	dfset = gcf;
	sh = get(dfset,'user');
	flag = get(sh(3),'user'); 	

	%  flag = 0, if this is the first time through for this matrix, 
	%  but flag = 1 if only the window parameters have changed.

	if (flag == 1)
		set(dfset,'user',sh);	
		dfdisp = 0;
		figs = get(0,'children');
		for (kk = 1:length(figs))
			if (strcmp(get(figs(kk),'name'),'MAP Display'))
				dfdisp = figs(kk);
			end
		end
		dh = get(dfdisp,'user');
		set(dfdisp,'user',dh);
		map('display')
	else
		set(sh(3),'user',1);
		set(dfset,'user',sh);	
		map('display');
	end	


elseif strcmp(action,'clear')

% Clear

        % dfset = 1;
        figs = get(0,'children');
        for (kk = 1:length(figs))
                if (strcmp(get(figs(kk),'name'),'MAP Setup'))
                        dfset = figs(kk);
                end
        end

        sh = get(dfset,'user');

% Find MAP Display if it exists.

        figs = get(0,'children');
        dfdisp = 0;
        for (figno = 1:length(figs))
                if (strcmp(get(figs(figno),'name'),'MAP Display'))
                        dfdisp = figs(figno);
                        figure(dfdisp);
                        dh = get(dfdisp,'user');
                        cla
                        notice = dh(2:3);
                        set(notice(1),'string','Initializing the window.');
                        set(notice(2),'string','');
                end
        end

        sh = get(dfset,'user');
        settings = sh(24:29);
        Matrix = sh(15:18);
	Object = sh(23);

        sm = get(sh(1),'user');
        set(sh(2),'user',sm);   % Resets long term storage.

        set(gcf,'user',sh);

        dh(10:13) = Matrix;
        set(dfdisp,'user',dh);
        dm = get(dh(1),'user');
        set(dh(1),'user',dm);

        dh = get(gcf,'user');
        notice = dh(2:3);

        title('(x,y)-Plane');
        xlabel('x');ylabel('y');

        set(notice(1),'string','Ready.');
        set(notice(2),'string','');

	ax = dh(23);
        axis('square');
        axis([-ax ax -ax ax]);
	
elseif strcmp(action,'revert')

% Revert allows the user to change all settings in the Setup window to
% what they were before changes have been made.

	sh = get(gcf,'user');
	frame=sh(1:2);
	wind =sh(3:11);
	sm = get(sh(2),'user');

	set(sh(1),'user',sm);
	
	set(wind(2),'string',['A11 = ']);
	set(wind(4),'string',['A21 = ']);
	set(wind(6),'string',['A12 = ']);
	set(wind(8),'string',['A22 = ']);
	set(wind(3),'string',num2str(sh(19)));
	set(wind(5),'string',num2str(sh(20)));
	set(wind(7),'string',num2str(sh(21)));
	set(wind(9),'string',num2str(sh(22)));
        Matrix = sh(15:18);
        sh(15:18) = sh(19:22);
	sh(19:22) = Matrix;
	set(gcf,'user',sh);
	map('display')

elseif strcmp(action,'display')

% Display takes the information from the Setup window and initializes
% the Display window if it already exists.  If the Display window does
% not exist, it builds one.
	
	dfset = gcf;

% Find MAP Display if it exists.
	
	figs = get(0,'children');
	dfdisp = 0;
	for (figno = 1:length(figs))
		if (strcmp(get(figs(figno),'name'),'MAP Display'))
			dfdisp = figs(figno);
			figure(dfdisp);
			dh = get(dfdisp,'user');
			cla
			notice = dh(2:3);
			set(notice(1),'string','Initializing the window.');
			set(notice(2),'string','');
		end
	end

% Get the information from MAP Setup.

	sh = get(dfset,'user');
	settings = sh(24:29);
	Matrix = sh(15:18);
	Object = sh(23);
	
	sm = get(sh(1),'user');
	set(sh(2),'user',sm);	% Resets long term storage.
	
	sh(19:22) = Matrix;
	set(gcf,'user',sh);

% If MAP Display exists, update it.  If it does not build it.
		
	if (dfdisp)
		dh(10:13) = Matrix;
		dh(14:17) = Matrix;
		set(dfdisp,'user',dh);
		dm = get(dh(1),'user');
		set(dh(1),'user',dm);
	else
		dfdisp = figure('name','MAP Display','numb','off');
		figure(dfdisp);
		
		% Set up the bulletin window.
		
		nframe = uicontrol('style','frame','units','normal',...
			'pos',[.1 0 .78 .09]);
		
		notice(1)=uicontrol('style','text','units','normal',...
			'pos',[.12 .045 .74 .04],'horiz','left',...
			'string','Initializing the window.');
		
		notice(2)=uicontrol('style','text','units','normal',...
			'pos',[.12 .005 .74 .04],'horiz','left','string','');
		
		drawnow
		
		% Set up the buttons and the menu.

		if exist('gco') vstr = 'on'; 
		else vstr = 'off';end
		
		dbutt(1) = uicontrol('style','push','units','normal','pos',...
			[0.9 0.70 0.08 0.06],'string','Map',...
			'call','map(''mapobject'')');
		
%		dbutt(2) = uicontrol('style','push','units','normal','pos',...
%			[0.85 0.74 0.13 0.06],'string','Keyboard','call','map(''kbd'')',...
%			'visible','off');

		dbutt(2) = uicontrol('style','push','units','normal','pos',...
			[0.85 0.30 0.13 0.06],'string','Go away','call','delete(gcf)',...
			'visible','on');

		dbutt(3) = uicontrol('style','push','units','normal','pos',...
			[0.9 0.67 0.08 0.06],'string','Print',...
			'call','map(''print'')','visible','off');

		dbutt(4) = uicontrol('style','push','units','normal','pos',...
			[0.9 0.50 0.08 0.06],'string','Clear',...
			'call','map(''clear'')');

		menu(1) = uimenu('label','MAP Options');

		%menukey = uimenu(menu(1),'label','Keyboard input.','call',...
		%	'map(''kbd'')');

		menuradius = uimenu(menu(1),'label','Change x-max','call',...
			'map(''radius'')');

		menuscale = uimenu(menu(1),'label','Rescale.','call',...
			'map(''rescale'')');

		menucolor = uimenu(menu(1),'label','Color.','call',...
			'map(''color'')');

		menutext = uimenu(menu(1),'label','Enter text on the Display Window.',...
			'call','map(''text'')');

		menuicons = uimenu('label','Icons');

		mevector  = uimenu(menuicons,'label','Vector',...
			'call','map(''vector'')');

		mebasis  = uimenu(menuicons,'label','Standard basis',...
			'call','map(''basis'')');

		mesquare  = uimenu(menuicons,'label','Unit square',...
			'call','map(''square'')');

		merectangle  = uimenu(menuicons,'label','Rectangle',...
			'call','map(''rectangle'')');

		medog  = uimenu(menuicons,'label','Dog',...
			'call','map(''dog'')');

		dfdispa=axes('position',[.1 .17 .78 .75],...
			'next','add','box','on',...
			'xgrid','on','ygrid','on');

		set(gcf,'WindowButtonDownFcn','map(''down'')');
	
	% Save the numbers:
	
		% dh(1)			nframe
		% dh(2:3)		notice
		% dh(4:7)		butt
		% dh(8) 		menu
		% dh(9) 		ddispa
		% dh(10:13)		Matrix
		% dh(14:17) 		Martix
		% dh(18)		Object
		% dh(19)		Color
		% dh(20:21)		Vector 
		% dh(22)		Rescale
		% dh(23)		ax
		% dh(24)		colo = color

		dh = [nframe,notice,dbutt(1:4),menu,dfdispa,Matrix,Matrix,Object,settings];
		set(dfdisp,'user',dh);

	end
		
        % Set up the original mesh.

        dh = get(gcf,'user');
        notice = dh(2:3);

	ax = dh(23);

        title('(x,y)-Plane');
        xlabel('x');ylabel('y');

        set(notice(1),'string','Ready.');
        set(notice(2),'string','');
        axis('square');
        axis([-ax ax -ax ax]);

	
elseif strcmp(action,'down')

% 'down' is the Window Button Down call.

	dh = get(gcf,'user');
	notice = dh(2:3);

if ((dh(18) == 1) | (dh(18) == 3) | dh(18) == 4)
	if (nargin == 1)
		initpt = get(gca,'currentpoint');
		initpt = initpt(1,[1,2]);
	else
		initpt = input1;
	end

	dh(20) = initpt(1);
	dh(21) = initpt(2);

	dh(14:17) = dh(10:13);

        set(gcf,'user',dh);

	if (dh(18) == 1)
		AX = initpt(1);
		AY = initpt(2);
		if (dh(22) == 1)
			s=sqrt(AX*AX+AY*AY);
			AX = AX/s;
			AY = AY/s;
		end

		figs = get(0,'children');
		for (kk = 1:length(figs))
			if (strcmp(get(figs(kk),'name'),'Vector input'))
				dfkbd = figs(kk);
				KBD = get(dfkbd,'user');

				set(KBD(1),'string',['x-coordinate = ']);
				set(KBD(3),'string',['y-coordinate = ']);
				set(KBD(2),'string',num2str(AX));
				set(KBD(4),'string',num2str(AY));
			end
		end
		if (dh(24) == 1)
			compass(AX,AY,'b');
		else
			compass(AX,AY,'k');
		end
	end

	if (dh(18) == 3)
		x=[0.8711    1.0166    1.1751    1.7441    2.0674    1.9413    1.8443,...
		1.7861    1.7279    1.2818    1.1977    1.1686    1.0490    1.0360   0.8679];
		y=[1.6176    1.8261    1.6097    1.5595    1.4302    1.3378    1.3378,...
		1.0422    1.3326    1.3378    1.0106    1.3194    1.4012    1.5886   1.6176];

		x = (x-1.5)+initpt(1);
		y = (y-1.4)+initpt(2);

		if (dh(24) == 1)
			fill(x,y,'b')
		else
			fill(x,y,'k')
		end
	end

        if (dh(18) == 4)
        	x=[0 2 2 0];
        	y=[0 0 1 1];

                x = (x-1.0)+initpt(1);
                y = (y-0.5)+initpt(2);

                if (dh(24) == 1)
                        fill(x,y,'b')
                else
                        fill(x,y,'k')
                end
        end

	set(notice(1),'string','Ready.')
	set(notice(2),'string',' ');

end

elseif strcmp(action,'update')

        kh = get(gcf,'user');
        initpt = [str2num(get(kh(2),'string')),str2num(get(kh(4),'string'))];
        figs = get(0,'children');
        dfdisp = 0;
        for (figno = 1:length(figs));
                if (strcmp(get(figs(figno),'name'),'MAP Display'))
                        dfdisp = figs(figno);
                end
        end

        figure(dfdisp);
        map('down',initpt);

elseif strcmp(action,'vector')

% Position 'vector'

        dh = get(gcf,'user');
        notice = dh(2:3);

        set(gcf,'WindowButtonDownFcn','map(''down'')');

        dh(14:17) = dh(10:13);

        Object = 1;
        dh(18) = Object;
        dh(19) = 0;

        cla

        hold on

        title('(x,y)-Plane');
        xlabel('x');ylabel('y');

	ax = 2;
	dh(23) = ax;
        axis([-ax,ax,-ax,ax])
        axis('square')

        set(gcf,'user',dh);

        dm = get(dh(1),'user');

        txtl = 175;txth = 18;

        dfkbd = figure('pos',[30 200 (txtl+52) (9*txth)],...
                'resize','off','name','Vector input','numb','off');
        figure(dfkbd)

        KBD(1) = uicontrol('style','text','pos',[1 7*txth txtl-15 txth],...
                'horiz','right','string',['x-coordinate = ']);

        KBD(2) = uicontrol('style','edit','pos',[txtl-15 7*txth 65 txth],...
                'string','','call','');

        KBD(3) = uicontrol('style','text','pos',[1 5*txth txtl-15 txth],...
                'horiz','right',...
                'string',['y-coordinate = ']);

        KBD(4) = uicontrol('style','edit','pos',[txtl-15 5*txth 65 txth],...
                'string','');

        KBD(5) = uicontrol('style','push',...
                'pos',[(txtl+52)/2-35 3*txth 70 txth],...
                'string','Set','call','map(''update'')');

        KBD(6) = uicontrol('style','push',...
                'pos',[(txtl+52)/2-35,txth,70,txth],...
                'string','Close','call','close');

        set(dfkbd,'user',KBD);

        set(notice(1),'string','Choose a vector with the mouse.')
        set(notice(2),'string',' ');


elseif strcmp(action,'basis')

% Plot 'basis'

	map('closekbd');

        dh = get(gcf,'user');
        notice = dh(2:3);

	dh(14:17) = dh(10:13);
	
	Object = 2;
	dh(18) = Object;
	dh(19) = 0;

	cla

	x=[0 0 1 1];
	y=[0 1 1 0];

	hold on

	if (dh(24) == 1)
        	compass(1,0,'b--');
        	compass(0,1,'b');
	else
		compass(1,0,'k--');
                compass(0,1,'k');
	end

        title('(x,y)-Plane');
        xlabel('x');ylabel('y');

	ax = 2;
	dh(23) =ax;
        axis([-ax,ax,-ax,ax])
        axis('square')

        set(gcf,'user',dh);

        set(notice(1),'string','Ready.')
        set(notice(2),'string',' ');


elseif strcmp(action,'rectangle')

% Position 'rectangle'

        map('closekbd');

        dh = get(gcf,'user');
        notice = dh(2:3);

        set(gcf,'WindowButtonDownFcn','map(''down'')');

        dh(14:17) = dh(10:13);

        Object = 4;
        dh(18) = Object;
        dh(19) = 0;

        cla

        hold on

        title('(x,y)-Plane');
        xlabel('x');ylabel('y');

	ax = 4;
	dh(23) = ax;
        axis([-ax,ax,-ax,ax])
        axis('square')

        set(gcf,'user',dh);

	set(notice(1),'string','Choose a position for the rectangle with the mouse.')
        set(notice(2),'string',' ');

elseif strcmp(action,'square')

% Plot 'square'

        map('closekbd');

        dh = get(gcf,'user');
        notice = dh(2:3);

        dh(14:17) = dh(10:13);

        Object = 5;
        dh(18) = Object;
        dh(19) = 0;

        cla

        x=[0 1 1 0];
        y=[0 0 1 1];

        hold on

        if (dh(24) == 1)
               fill(x,y,'b')
        else
               fill(x,y,'k')
        end

        title('(x,y)-Plane');
        xlabel('x');ylabel('y');

        ax = 2;
        dh(23) = ax;
        axis([-ax,ax,-ax,ax])
        axis('square')

        set(gcf,'user',dh);

        set(notice(1),'string','Ready.')
        set(notice(2),'string',' ');



elseif strcmp(action,'dog')

% Position 'dog'

	map('closekbd');

        dh = get(gcf,'user');
        notice = dh(2:3);

        set(gcf,'WindowButtonDownFcn','map(''down'')');

	dh(14:17) = dh(10:13);

        Object = 3;
        dh(18) = Object;
	dh(19) = 0;

	cla

	hold on

	title('(x,y)-Plane');
        xlabel('x');ylabel('y');

	ax = 2.4;
	dh(23) = ax;
        axis([-ax,ax,-ax,ax])
        axis('square')

        set(gcf,'user',dh);

	set(notice(1),'string','Choose a position for the dog with the mouse.')
        set(notice(2),'string',' ');


elseif strcmp(action,'mapobject')

% 'mapobject' is mapping the respective object

        dh = get(gcf,'user');
        notice = dh(2:3);

	Object = dh(18);
	C = dh(19);
	colo = dh(24);

	if (Object == 0)
	        set(notice(1),'string','Specify an icon first.')
        	set(notice(2),'string',' ');

        elseif (Object == 1)

                x=dh(20);
                y=dh(21);

		ax = dh(23);

                M = zeros(2,2);

                M(1,1) = dh(10);
                M(2,1) = dh(11);
                M(1,2) = dh(12);
                M(2,2) = dh(13);

                AX = M(1,1)*x + M(1,2)*y;
                AY = M(2,1)*x + M(2,2)*y;

		if (dh(22) == 1)
			s=sqrt(AX*AX+AY*AY);
			AX = AX/s;
			AY = AY/s;
		end

		if (colo == 1)
                	k = rem(C,6);
                	if     (k==0) compass(AX,AY,'y');
                	elseif (k==1) compass(AX,AY,'m');
                	elseif (k==2) compass(AX,AY,'c');
                	elseif (k==3) compass(AX,AY,'r');
                	elseif (k==4) compass(AX,AY,'g');
                	elseif (k==5) compass(AX,AY,'b');
                	end
                	dh(19) = dh(19) + 1;
		else
			compass(AX,AY,'k');
		end;

                axis([-ax,ax,-ax,ax])
                axis('square')

		dh(20) = AX;
		dh(21) = AY;

                set(gcf,'user',dh);

                set(notice(1),'string','Ready.')
                set(notice(2),'string',' ');

        	figs = get(0,'children');
        	for (kk = 1:length(figs))
                	if (strcmp(get(figs(kk),'name'),'Vector input'))
                        	dfkbd = figs(kk);
				KBD = get(dfkbd,'user');

                		set(KBD(1),'string',['x-coordinate = ']);
                		set(KBD(3),'string',['y-coordinate = ']);
                		set(KBD(2),'string',num2str(AX));
                		set(KBD(4),'string',num2str(AY));
                	end
        	end

        elseif (Object == 2)
		x=[0 0 1 1];
        	y=[0 1 1 0];

		ax = dh(23);

        	A = zeros(2,2);
        	M = zeros(2,2);

        	A(1,1) = dh(14);
        	A(2,1) = dh(15);
        	A(1,2) = dh(16);
        	A(2,2) = dh(17);

        	M(1,1) = dh(10);
        	M(2,1) = dh(11);
        	M(1,2) = dh(12);
        	M(2,2) = dh(13);

        	for i=1:4
                	AX(i) = A(1,1)*x(i) + A(1,2)*y(i);
                	AY(i) = A(2,1)*x(i) + A(2,2)*y(i);
        	end

		if (colo == 1)
                	k = rem(C,6);
                	if     (k==0) compass(AX(4),AY(4),'y--');
			      compass(AX(2),AY(2),'y');
                	elseif (k==1) compass(AX(4),AY(4),'m--');
			      compass(AX(2),AY(2),'m');
                	elseif (k==2) compass(AX(4),AY(4),'c--');
			      compass(AX(2),AY(2),'c');
                	elseif (k==3) compass(AX(4),AY(4),'r--');
			      compass(AX(2),AY(2),'r');
                	elseif (k==4) compass(AX(4),AY(4),'g--');
			      compass(AX(2),AY(2),'g');
                	elseif (k==5) compass(AX(4),AY(4),'b--');
			      compass(AX(2),AY(2),'b');
                	end
			dh(19) = dh(19) + 1;
		else
			compass(AX(4),AY(4),'k--');
                        compass(AX(2),AY(2),'k');
		end

        	axis([-ax,ax,-ax,ax])
        	axis('square')

		A = A*M;

		dh(14) = A(1,1);
		dh(15) = A(2,1);
		dh(16) = A(1,2);
		dh(17) = A(2,2);

	        set(gcf,'user',dh);

        	set(notice(1),'string','Ready.')
        	set(notice(2),'string',' ');

	elseif (Object == 3)

	xp = dh(20);
	yp = dh(21);

        x=[0.8711    1.0166    1.1751    1.7441    2.0674    1.9413    1.8443,...
                1.7861    1.7279    1.2818    1.1977    1.1686    1.0490    1.0360   0.8679];
        y=[1.6176    1.8261    1.6097    1.5595    1.4302    1.3378    1.3378,...
                1.0422    1.3326    1.3378    1.0106    1.3194    1.4012    1.5886   1.6176];

		x = (x-1.5)+xp;
		y = (y-1.4)+yp;

		ax = dh(23);

                A = zeros(2,2);
                M = zeros(2,2);

                A(1,1) = dh(14);
                A(2,1) = dh(15);
                A(1,2) = dh(16);
                A(2,2) = dh(17);

                M(1,1) = dh(10);
                M(2,1) = dh(11);
                M(1,2) = dh(12);
                M(2,2) = dh(13);

                for i=1:length(x)
                        AX(i) = A(1,1)*x(i) + A(1,2)*y(i);
                        AY(i) = A(2,1)*x(i) + A(2,2)*y(i);
                end

		if (colo == 1)
			k = rem(C,6);
			if     (k==0) fill(AX,AY,'y')
			elseif (k==1) fill(AX,AY,'m')
			elseif (k==2) fill(AX,AY,'c')
			elseif (k==3) fill(AX,AY,'r')
			elseif (k==4) fill(AX,AY,'g')
			elseif (k==5) fill(AX,AY,'b')
			end
			dh(19) = dh(19)+1;
		else
			fill(AX,AY,'k')
		end

                axis([-ax,ax,-ax,ax])
                axis('square')

                A = A*M;

                dh(14) = A(1,1);
                dh(15) = A(2,1);
                dh(16) = A(1,2);
                dh(17) = A(2,2);

                set(gcf,'user',dh);

                set(notice(1),'string','Ready.')
                set(notice(2),'string',' ');
	
elseif (Object == 4)

	        xp = dh(20);
       		yp = dh(21);

                x=[0 2 2 0];
                y=[0 0 1 1];

                x = (x-1.0)+ xp;
                y = (y-0.5)+ yp;

		ax = dh(23);

                A = zeros(2,2);
                M = zeros(2,2);

                A(1,1) = dh(14);
                A(2,1) = dh(15);
                A(1,2) = dh(16);
                A(2,2) = dh(17);

                M(1,1) = dh(10);
                M(2,1) = dh(11);
                M(1,2) = dh(12);
                M(2,2) = dh(13);

                for i=1:length(x)
                        AX(i) = A(1,1)*x(i) + A(1,2)*y(i);
                        AY(i) = A(2,1)*x(i) + A(2,2)*y(i);
                end

		if (colo == 1)
                	k = rem(C,6);
                	if     (k==0) fill(AX,AY,'y')
                	elseif (k==1) fill(AX,AY,'m')
                	elseif (k==2) fill(AX,AY,'c')
                	elseif (k==3) fill(AX,AY,'r')
                	elseif (k==4) fill(AX,AY,'g')
                	elseif (k==5) fill(AX,AY,'b')
                	end
                	dh(19) = dh(19)+1;
		else
			fill(AX,AY,'k')
		end

                axis([-ax,ax,-ax,ax])
                axis('square')

                A = A*M;

                dh(14) = A(1,1);
                dh(15) = A(2,1);
                dh(16) = A(1,2);
                dh(17) = A(2,2);

                set(gcf,'user',dh);

                set(notice(1),'string','Ready.')
                set(notice(2),'string',' ');

elseif (Object == 5)

                x=[0 1 1 0];
                y=[0 0 1 1];

                ax = dh(23);

                A = zeros(2,2);
                M = zeros(2,2);

                A(1,1) = dh(14);
                A(2,1) = dh(15);
                A(1,2) = dh(16);
                A(2,2) = dh(17);

                M(1,1) = dh(10);
                M(2,1) = dh(11);
                M(1,2) = dh(12);
                M(2,2) = dh(13);

                for i=1:length(x)
                        AX(i) = A(1,1)*x(i) + A(1,2)*y(i);
                        AY(i) = A(2,1)*x(i) + A(2,2)*y(i);
                end

                if (colo == 1)
                        k = rem(C,6);
                        if     (k==0) fill(AX,AY,'y')
                        elseif (k==1) fill(AX,AY,'m')
                        elseif (k==2) fill(AX,AY,'c')
                        elseif (k==3) fill(AX,AY,'r')
                        elseif (k==4) fill(AX,AY,'g')
                        elseif (k==5) fill(AX,AY,'b')
                        end
                        dh(19) = dh(19)+1;
                else
                        fill(AX,AY,'k')
                end

                axis([-ax,ax,-ax,ax])
                axis('square')

                A = A*M;

                dh(14) = A(1,1);
                dh(15) = A(2,1);
                dh(16) = A(1,2);
                dh(17) = A(2,2);

                set(gcf,'user',dh);

                set(notice(1),'string','Ready.')
                set(notice(2),'string',' ');

	end


elseif strcmp(action,'kcompute')

% 'kcompute' is the call back for the Map button on the MAP Display figure.

	kh = get(gcf,'user');
	initpt = [str2num(get(kh(2),'string')),str2num(get(kh(4),'string'))];
	figs = get(0,'children');
	dfdisp = 0;
	for (figno = 1:length(figs));
		if (strcmp(get(figs(figno),'name'),'MAP Display'))
			dfdisp = figs(figno);
		end
	end

	figure(dfdisp);
	map('down',initpt);

	
elseif strcmp(action,'kbd')

% 'kbd' is the callback for the Keyboard Input menu selection.  It 
% sets up the MAP Keyboard figure which allows accurate input of 
% an intial vector 

	dh = get(gcf,'user');
	dm = get(dh(1),'user');

	txtl = 149;txth = 18;
	
	dfkbd = figure('pos',[30 200 (txtl+52) (9*txth)],...
		'resize','off','name','MAP Key input','numb','off');
	figure(dfkbd)
	
	
	KBD(1) = uicontrol('style','text','pos',[1 7*txth txtl txth],...
		'horiz','right','string',['x-coordinate = ']);
		
	KBD(2) = uicontrol('style','edit','pos',[txtl+1 7*txth 50 txth],...
		'string','','call','');
		
	KBD(3) = uicontrol('style','text','pos',[1 5*txth txtl txth],...
		'horiz','right',...
		'string',['y-coordinate = ']);
		
	KBD(4) = uicontrol('style','edit','pos',[txtl+1 5*txth 50 txth],...
		'string','');
		
	KBD(5) = uicontrol('style','push',...
		'pos',[(txtl+52)/2-35 3*txth 70 txth],...
		'string','Map','call','map(''kcompute'')');

	KBD(6) = uicontrol('style','push',...
		'pos',[(txtl+52)/2-35,txth,70,txth],...
		'string','Close','call','close');
		
	set(dfkbd,'user',KBD);


elseif strcmp(action,'rescale')

        dh = get(gcf,'user');
        dm = get(dh(1),'user');

        txtl = 189;txth = 18;

        dfrs = figure('pos',[30 200 (txtl) (8*txth)],...
                'resize','off','name','MAP Rescale','numb','off');
        figure(dfrs)


        RS(1) = uicontrol('style','text','pos',[32 6*txth 120 txth],...
                'horiz','right','string',['Rescale vectors?']);

        RS(2) = uicontrol('style','push',...
                'pos',[(txtl+52)/2-60 3*txth 70 txth],...
                'string','Yes','call','map(''setrescale'',1),close');

        RS(3) = uicontrol('style','push',...
                'pos',[(txtl+52)/2-60,txth,70,txth],...
                'string','No','call','map(''setrescale'',0),close');

        set(dfrs,'user',RS);


elseif strcmp(action,'setrescale')

        figs = get(0,'children');
        dfdisp = 0;
        for (figno = 1:length(figs));
                if (strcmp(get(figs(figno),'name'),'MAP Display'))
                        dfdisp = figs(figno);
                end
        end

        dh = get(dfdisp,'user');

	dh(22) = input1;

        set(dfdisp,'user',dh);


elseif strcmp(action,'color')

        dh = get(gcf,'user');
        dm = get(dh(1),'user');

        txtl = 189;txth = 18;

        dfrs = figure('pos',[30 200 (txtl) (8*txth)],...
                'resize','off','name','MAP Color','numb','off');
        figure(dfrs)


        RS(1) = uicontrol('style','text','pos',[32 6*txth 120 txth],...
                'horiz','right','string',['Icons in color?       ']);

        RS(2) = uicontrol('style','push',...
                'pos',[(txtl+52)/2-60 3*txth 70 txth],...
                'string','Yes','call','map(''setcolor'',1),close');

        RS(3) = uicontrol('style','push',...
                'pos',[(txtl+52)/2-60,txth,70,txth],...
                'string','No','call','map(''setcolor'',0),close');

        set(dfrs,'user',RS);

elseif strcmp(action,'setcolor')

        figs = get(0,'children');
        dfdisp = 0;
        for (figno = 1:length(figs));
                if (strcmp(get(figs(figno),'name'),'MAP Display'))
                        dfdisp = figs(figno);
                end
        end

        dh = get(dfdisp,'user');

        dh(24) = input1;

        set(dfdisp,'user',dh);


elseif strcmp(action,'radius')

     dh = get(gcf,'user');
     dm = get(dh(1),'user');

     txtl = 189;txth = 18;

     dfrs = figure('pos',[30 200 (txtl+10) (8*txth)],...
                'resize','off','name','MAP X-Max','numb','off');
     figure(dfrs)

     KBD(1) = uicontrol('style','text','pos',[1 6*txth txtl-55 txth],...
                'horiz','right','string',['New x-max = ']);

     KBD(2) = uicontrol('style','edit','pos',[txtl-55 6*txth 75 txth],...
                'string','','call','');

     KBD(3) = uicontrol('style','push',...
                'pos',[(txtl+52)/2-55 3*txth 70 txth],...
                'string','Set','call','map(''setradius'')');

     KBD(4) = uicontrol('style','push',...
                'pos',[(txtl+52)/2-55,txth,70,txth],...
                'string','Close','call','close');

     set(dfrs,'user',KBD);


elseif strcmp(action,'setradius')

     kh = get(gcf,'user');
     ax = [str2num(get(kh(2),'string'))];

     figs = get(0,'children');
     dfdisp = 0;
     for (figno = 1:length(figs));
                if (strcmp(get(figs(figno),'name'),'MAP Display'))
                        dfdisp = figs(figno);
                end
     end

     dh = get(dfdisp,'user');

     dh(23) = ax;

     figure(dfdisp)

     axis([-ax,ax,-ax,ax])
     axis('square')

     set(dfdisp,'user',dh);



elseif strcmp(action,'text')

  dh = get(gcf,'user');
  mapdisp = gcf;
  oldcall = get(mapdisp,'WindowButtonDownFcn');
  set(mapdisp,'WindowButtonDownFcn','');
  prompt = ['Enter the text here. Then choose ',...
        'the location in the Display Window.'];
  txtstr = inputdlg(prompt,'Text entry');
  if ~isempty(txtstr)
    txtstr = txtstr{1};
    figure(mapdisp);
    gtext(txtstr);
  end
  set(mapdisp,'WindowButtonDownFcn',oldcall);



elseif strcmp(action,'print')

% 'print' is the callback of the Print button.

	dh = get(gcf,'user');
	dm = get(dh(1),'user');
	notice = dh(2:3);
	set(notice(1),'string','Preparing to print the MAP Display Window.');
	set(notice(2),'string','Please be patient.');
	dfdispa = dh(9);
	set(notice(1),'string','Printing the MAP Display Window.');
	print
	set(notice(1),'string','Ready.');
	set(notice(2),'string','');
	
elseif strcmp(action,'closekbd')
	
figs = get(0,'children');
        for (figno = 1:length(figs))
                nn = get(figs(figno),'name');
                if (length(nn) > 1)
                        if (~isempty(findstr(nn,'Vector')))
                                close(figs(figno))
                        end
                end
        end

elseif strcmp(action,'quit')

% 'quit' is the callback of the Quit buttons on the MAP Setup and MAP
% Display windows.  It provides for an orderly exit, deleting all
% associated windows.

	figs = get(0,'children');
	dfdisp = 0;
	for (figno = 1:length(figs))
		nn = get(figs(figno),'name');
		if (length(nn) > 1)
			if (strcmp(nn,'MAP Display'))
				dfdisp = figs(figno);
				dh = get(dfdisp,'user');
				dm = get(dh(1),'user');
				close(dfdisp)
			elseif (~isempty(findstr(nn,'MAP')))
				close(figs(figno))		
			elseif (~isempty(findstr(nn,'Vector')))
				close(figs(figno))		
			end
		end
	end
end


