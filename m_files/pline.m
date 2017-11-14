function output = pline(action,input1,input2,input3)

rand('state',sum(100*clock));

if nargin <1
	action ='initialize';
end

if strcmp(action,'initialize')

	% First we make sure that there is no other copy of PLINE
	% running, since this causes problems.

	figs = get(0,'children');
	for (figno = 1:length(figs))
		nn = get(figs(figno),'name');
		if (length(nn) >1)
			if (findstr(nn,'PLINE')~=[])
				error('Only one copy of PLINE can be open at one time.')
			end
		end
	end

	% Initiate several parameters.

	plotspeed = 0;	        % Controls the speed of the plot
	Arrflag=1;		% The default is a vector field.
	msize = 5;		% The size of the marker
				% for the compute window.
	dummy = 1;		% color for the marker (0 no; 1 yes)
				% the Display window.
	tol = 1e-3;		% The relative error tolerance.
	itlim = 1000;		% After this many iterations, the computation of 
				% a solution stops.
	settings = [Arrflag,plotspeed,tol,msize,dummy,itlim];

	% The default differential equation, and Display window.

	Xname = ' x';
	derivstr = ' lambda*x';
	Pname = 'lambda';
	WINvect=[-4 4 5 -0.8];

	% Build the Setup window.
	
	texth =20;   		% Height of text boxes.
	varw = 80;		% Length of variable boxes.
	equalw =30;		% Length of equals.
	eqlength = 300;		% Length of right hand sides.
	left =30;		% Left margin.
	
	separation = texth+3;	% Separation between boxes.
	equationbot = 7.5*separation;;
	eqlabelbot = equationbot + 2.5*separation;
	xbot = equationbot + 1.5*separation;	% Bottom of x equation.
	tbot = equationbot;			% Bottom of t equation.
	
	defigwidth =2*left + varw+equalw+eqlength;	% Width of the figure.
	defigureheight = 12*separation;			% Height of the figure.
	defigurebot = 20;				% Bottom of the figure.
	
	dfset = figure('pos',[20 defigurebot defigwidth defigureheight],...
		'resize','off','name','PLINE Setup','numb','off');
	figure(dfset)

	lablen =160;
	
	eqlableft = (defigwidth-lablen)/2;
	
	frame(1) = uicontrol('style','frame',...
		'pos',[left-5,equationbot-5,defigwidth-2*left+10,3.5*separation+10]);

	pname = [
	'sh = get(gcf,''user'');'...
	'sm = get(sh(1),''user'');'...
	'eq = sh(3:8);'...
	'wind =sh(9:17);'...
	'Pname=get(eq(6),''string'');'...
	'set(wind(8),''string'',[''The value of '',Pname,'' = '']);'...
	'sm = str2mat(sm(1,:),sm(2,:),Pname);'...
	'set(sh(1),''user'',sm);'...
	'set(sh(3),''user'',0);']; 	% Set's the flag to compute anew.

	xname=[
	'sh = get(gcf,''user'');'...
	'sm = get(sh(1),''user'');'...
	'eq = sh(3:8);'...
	'wind =sh(9:17);'...
	'Xname=get(eq(2),''string'');'...
	'set(wind(2),''string'',[''The min value of '',Xname,'' = '']);'...
	'set(wind(4),''string'',[''The max value of '',Xname,'' = '']);'...
	'sm = str2mat(Xname,sm(2,:),sm(3,:));'...
	'set(sh(1),''user'',sm);'...
	'set(sh(3),''user'',0);'];

	xder =[
	'sh = get(gcf,''user'');'...
	'sm = get(sh(1),''user'');'...
	'eq=sh(3:8);'...
	'derivstr = get(eq(4),''string'');'...
	'sm = str2mat(sm(1,:),derivstr,sm(3,:));'...
	'set(sh(1),''user'',sm);'...
	'set(sh(3),''user'',0);'];


	eq(1)=uicontrol('style','text',...
		'pos',[left eqlabelbot defigwidth-2*left texth],...
		'horizon','center',...
		'string','The differential equation.');
	
	eq(2)=uicontrol('pos',[left xbot varw texth],'style','edit',...
		'horizon','right','string',Xname,...
		'call',xname);
	
	eq(3) = uicontrol('style','text','pos',[left+varw xbot equalw texth],...
		'horizon','center','string',''' = ');
		
	eq(4)=uicontrol('pos',[left+varw + equalw xbot eqlength texth],...
		'string',derivstr,'horizon','left','style','edit',...
		'call',xder);
		
	eq(5)=uicontrol('pos',[left tbot 200 texth],'style','text',...
		'horizon','right','string','The parameter is ');
			
	eq(6)=uicontrol('pos',[left+200 tbot varw texth],...
		'string',Pname,...
		'horizon','right','style','edit','call',pname);
	
	winstrlen = (defigwidth - 2*left)/2 -50;
	winbot = 2*separation;
	winleft = left+(winstrlen +50 -120)/2;
	wframe=[left-5,winbot+separation-5,...
		defigwidth-2*left+10,3*separation+10];
		
	w1 = [
	'sh = get(gcf,''user'');'...
	'wind =sh(9:17);'...
	'sh(21)=str2num(get(wind(3),''string''));'...
	'set(gcf,''user'',sh);'];
	
	w2 = [
	'sh = get(gcf,''user'');'...
	'wind =sh(9:17);'...
	'sh(22)=str2num(get(wind(5),''string''));'...
	'set(gcf,''user'',sh);'];
	
        w3 = [
        'sh = get(gcf,''user'');'...
        'wind =sh(9:17);'...
        'sh(23)=str2num(get(wind(7),''string''));'...
        'set(gcf,''user'',sh);'];

        w4 = [
        'sh = get(gcf,''user'');'...
        'wind =sh(9:17);'...
        'sh(24)=str2num(get(wind(9),''string''));'...
        'set(gcf,''user'',sh);'];
	
	frame(2) = uicontrol('style','frame','pos',wframe);
	
	wind(1)=uicontrol('style','text',...
		'pos',[left winbot+3*separation defigwidth - 2*left texth],...
		'horizon','center','string','The display window.');
		
	wind(2) = uicontrol('style','text',...
		'pos',[left winbot+2*separation winstrlen texth],...
		'horizon','right','string',['The min value of ',Xname,' = ']);

	wind(3) = uicontrol('style','edit',...
		'pos',[left+winstrlen winbot+2*separation 50 texth],...
		'string',num2str(WINvect(1)),...
		'call',w1);
	
	wind(4) = uicontrol('style','text',...
		'pos',[left+winstrlen+50 winbot+2*separation winstrlen texth],...
		'horizon','right','string',['The max value of ',Xname,' = ']);

	wind(5) = uicontrol('style','edit',...
		'pos',[left+2*winstrlen+50 winbot+2*separation 50 texth],...
		'string',num2str(WINvect(2)),...
		'call',w2);
	
        wind(6) = uicontrol('style','text',...
                'pos',[left winbot+separation winstrlen texth],...
                'horizon','right','string',['Integration time = ']);

        wind(7) = uicontrol('style','edit',...
                'pos',[left+winstrlen winbot+separation 50 texth],...
                'string',num2str(WINvect(3)),...
                'call',w3);

        wind(8) = uicontrol('style','text',...
                'pos',[left+winstrlen+50 winbot+separation winstrlen texth],...
                'horizon','right','string',['The value of ',Pname,' = ']);

        wind(9) = uicontrol('style','edit',...
                'pos',[left+2*winstrlen+50 winbot+separation 50 texth],...
                'string',num2str(WINvect(4)),...
                'call',w4);

	butt(1) = uicontrol('style','push',...
		'pos',[(defigwidth/4-35),separation,70,texth],...
		'string','Quit','call','pline(''quit'')');
	
	butt(2) = uicontrol('style','push',...
		'pos',[(defigwidth/2-35),separation,70,texth],...
		'string','Revert','call','pline(''revert'')');
		
	butt(3) = uicontrol('style','push',...
		'pos',[(3*defigwidth/4-35),separation,70,texth],...
		'string','Proceed','call','pline(''proceed'')');
		
% Record the handles in the User Data of the Set Up figure.
		
	sh = [frame,eq,wind,butt,WINvect,WINvect,settings];
	set(gcf,'user',sh);
	
% Record the important information in the User Data of
% various controls.  

	sm = str2mat(Xname,derivstr,Pname);
	set(frame(1),'user',sm);
	set(frame(2),'user',sm);	%  This is long term memory.
	set(sh(3),'user',0);
		

elseif strcmp(action,'proceed')

% Proceed connects Setup with the Display window.

	dfset = gcf;
	sh = get(dfset,'user');
	flag = get (sh(3),'user'); 	

        sm = get(sh(1),'user');

	%  flag = 0, if this is the first time through for this equation, 
	%  but flag = 1 if only the window dimensions have been changed.

	if (flag == 1)
		WINvect = sh(21:24);
		set(dfset,'user',sh);	
		dfdisp = 0;
		figs = get(0,'children');
		for (kk = 1:length(figs))
			if (strcmp(get(figs(kk),'name'),'PLINE Display'))
				dfdisp = figs(kk);
			end
		end
		dh = get(dfdisp,'user');
		dh(10:13) = WINvect;
		set(dfdisp,'user',dh);
		pline('display');
	else
		set(sh(3),'user',1);
		set(dfset,'user',sh);	
		pline('display');
	end	

			
elseif strcmp(action,'clear')
 
% Find PLINE Display if it exists.
 
        figs = get(0,'children');
        dfdisp = 0;
        for (figno = 1:length(figs))
                if (strcmp(get(figs(figno),'name'),'PLINE Display'))
                        dfdisp = figs(figno);
                        figure(dfdisp);
                        dh = get(dfdisp,'user');
                        cla
                end
        end
 
 
elseif strcmp(action,'revert')

% Revert allows the user to change all settings in the Setup window to
% what they were before changes have been made.

	sh = get(gcf,'user');
	frame=sh(1:2);
	eq=sh(3:8);
	wind =sh(9:17);
	so = get(sh(1),'user');
	sm = get(sh(2),'user');
	Xname = deblank(sm(1,:));
	derivstr = deblank(sm(2,:));
	Pname = deblank(sm(3,:));
	WINvect = sh(25:28);

	set(sh(2),'user',so);
	set(sh(1),'user',sm);
	
	set(eq(2),'string',Xname);
	set(wind(2),'string',['The min value of ',Xname,' = ']);
	set(wind(4),'string',['The max value of ',Xname,' = ']);
	set(wind(6),'string',['Integration time = ']);
	set(wind(8),'string',['The value of ',Pname,' = ']);
	set(eq(4),'string',derivstr);
	set(wind(3),'string',num2str(WINvect(1)));
	set(wind(5),'string',num2str(WINvect(2)));
	set(wind(7),'string',num2str(WINvect(3)));
	set(wind(9),'string',num2str(WINvect(4)));
	set(eq(6),'string',Pname);
	sh(25:28) = sh(21:24);
	sh(21:24) = WINvect;
	set(gcf,'user',sh);
	pline('display')

elseif strcmp(action,'display')

% Display takes the information from the Setup window and initializes
% the Display window if it already exists.  If the Display window does
% not exist, it builds one.
	
	dfset = gcf;

% Get the information from PLINE Setup.

        sh = get(dfset,'user');
        settings = sh(29:34);
        WINvect = sh(21:24);

        sm = get(sh(1),'user');

        Xname = deblank(sm(1,:));
        derivstr = deblank(sm(2,:));
	Pname = deblank(sm(3,:));
        Labstr = [Xname,''' = ',derivstr];

        set(gcf,'user',sh);

% Find PLINE Display if it exists.
	
	figs = get(0,'children');
	dfdisp = 0;
	for (figno = 1:length(figs))
		if (strcmp(get(figs(figno),'name'),'PLINE Display'))
			dfdisp = figs(figno);
			figure(dfdisp);
			dh = get(dfdisp,'user');
			cla
			axis([WINvect(1),WINvect(2),-100,100])
        		title(Labstr);
        		xlabel(Xname);
			notice = dh(2:3);
			set(notice(1),'string','Initializing window.');
			set(notice(2),'string','');
		end
	end

% If PLINE Display exists, update it.  If it does not build it.
		
	FFFCCNNN = ' ';

	if (dfdisp)
		dh(10:13) = WINvect;
		set(dfdisp,'user',dh);
		dm = get(dh(1),'user');
		FFFCCNNN = deblank(dm(2,:));
		dm = str2mat(Xname,FFFCCNNN,Labstr);
		set(dh(1),'user',dm);
	else
		dfdisp = figure('name','PLINE Display','numb','off');
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

		if exist('gco') vstr = 'on'; % gco does not exist in v 4.0.
		else vstr = 'off';end
		
		dbutt(1) = uicontrol('style','push','units','normal','pos',...
			[0.85 0.28 0.13 0.06],'string','Go away',...
			'call','pline(''goaway'')');
		
		dbutt(2) = uicontrol('style','push','units','normal','pos',...
			[0.86 0.77 0.12 0.06],'string','Clear',...
			'call','pline(''clear'')');
			
		dbutt(3) = uicontrol('style','push','units','normal','pos',...
			[0.86 0.58 0.12 0.06],'string','Continue',...
			'call','pline(''continue'')');
			
		dbutt(4) = uicontrol('style','push','units','normal','pos',...
			[0.85 0.74 0.13 0.06],'string','Keyboard','call','pline(''kbd'')',...
			'visible','off');

		menu(1) = uimenu('label','PLINE Options');

		menukey = uimenu(menu(1),'label','Keyboard input.','call',...
			'pline(''kbd'')');

		menutext = uimenu(menu(1),'label','Enter text on the Display Window.',...
			'call','pline(''text'')','visible','off');

                meplot  = uimenu('label','   Graph   ','visible','on');
 
		meset = uimenu(menu(1),'label','Settings',...
			'call','pline(''settings'')','visible','on','separator','on');

		menuxy = uimenu(meplot,'label',[Xname,' vs. t  '],...
                        'call','pline(''plotxy'',1)');

		set(gcf,'WindowButtonDownFcn','pline(''down'')');
	
	% Save the numbers:
	
		% dh(1)			nframe
		% dh(2:3)		notice
		% dh(4:7)		butt
		% dh(8)			menu
		% dh(9)			Intermediate x-value
		% dh(10:13)		WINvect
		% dh(14:19)		settings
		% dh(20:22)		Color
		% dh(23)		Free
		% dh(24) 		Intermediate time
	
		dfdispa=1.0;
		c = [1,0,0];
		dh(23)=0;
		dh(24)=0;

		dh = [nframe,notice,dbutt(1:4),menu,dfdispa,WINvect,settings,c];
		set(dfdisp,'user',dh);

		dm = str2mat(Xname,' ',Labstr);
		set(dh(1),'user',dm);
	
	        axes('position',[.1 .5 .8 .005],...
                       'Xlim',[WINvect(1),WINvect(2)],...
                       'Ycolor','k');
	
        	title(Labstr);
        	xlabel(Xname);
		
	end
	
% We have to make the derivative string array smart.
	
	l = length(derivstr);
	for (k=fliplr(find((derivstr=='^')|(derivstr=='*')|(derivstr=='/'))))
		derivstr = [derivstr(1:k-1) '.' derivstr(k:l)];
		l = l+1;
	end
	
% If an old function m-file exists delete it, and then build a new one.
	
	if (exist(FFFCCNNN)==2) delete([FFFCCNNN,'.m']);end
	tee = clock;
	tee = ceil(tee(6)*100);
	FFFCCNNN=['dftp',num2str(tee)];
	
	fcnstr = ['function YyYypr = ',FFFCCNNN,'(TtTt,YyYy)\n\n'];
	varstr = [Xname,' = YyYy;\n\n'];
	lenstr = ['l = length(YyYy);\n'];
	globstr = ['dh = get(gcf,''user'');\n'];
	parstr = [Pname, '= dh(13);\n'];
	derstr1= ['YyYypr = ', derivstr,';\n'];
	derstr2 = ['if (length(YyYypr) < l) YyYypr = YyYypr*ones(1,l);end\n'];
	
	dff = fopen([FFFCCNNN,'.m'],'w');
	fprintf(dff,fcnstr);
	fprintf(dff,varstr);
	fprintf(dff,lenstr);
	fprintf(dff,globstr);
	fprintf(dff,parstr);
	fprintf(dff,derstr1);
	fprintf(dff,derstr2);
	fclose(dff);

        for (figno = 1:length(figs))
                nn = get(figs(figno),'name');
                if (strcmp(nn,'PLINE t-plot'))
                                pline('clearxy');
                end
        end


% Initialize important information as user data.
	
	dm = str2mat(dm(1,:),FFFCCNNN,dm(3,:));
	set(dh(1),'user',dm);	% The strings.

        set(notice(1),'string','Ready.');
        set(notice(2),'string','');


elseif strcmp(action,'plotxy')
 
        dh = get(gcf,'user');
        dm = get(dh(1),'user');
        Xname = deblank(dm(1,:));
 
        texth = 24;
        textw = 100;
        figmargin = 15;
        frmargin = 5;
        sep = 30;
        lwid = textw + 10;      % The first guess at the width of the legend.
 
% The absolute position of the t-plot axes
 
        rr = 0.8;
 
        aleft = 73.8;
        abott = 47.2;
        awidth = 434*rr;
        aht =  342*rr;
 
        frsep = (aht - 10*texth-10)/3;
 
% The PLINE t-plot figure --- first guess.
 
        fwid1 = aleft + awidth + sep + figmargin;
        fwid = fwid1 + lwid;                            % This may change.
        fht = abott + aht + 32;
 
        pos = get(gcf,'position');
        figpos = [pos(1)+30,pos(2)-30,fwid,fht];
        ppxy = figure('name','PLINE t-plot','position',figpos,'number','off',...
                'visible','off');
        figure(ppxy);

%        set(ppxy,'user',[t;x;y]);
 
% The t-plot axes.  This changes with fwid.
 
        alft = aleft/fwid;
        awid = awidth/fwid;
        abot = abott/fht;
        aht = aht/fht;
        apos = [alft,abot,awid,aht];
 
        axy = axes('pos',apos,'box','on','xgrid','on','ygrid','on','next','add',...
                'drawmode','fast');
	xlabel('t');
	ylabel('x');
 
% The position of the close button
 
        bbot = abott;
        bwid = lwid;
        bleft = aleft + awidth + sep + (lwid - bwid)/2;
        bpos = [bleft,bbot,bwid,texth];
 
% The position of the print button.
 
        pbbot = bbot + texth + frsep;
        pbpos = [bleft, pbbot, lwid, texth];

% The position of the clear button.

	cbbot = bbot + 2*texth + 2*frsep;
        cbpos = [bleft, cbbot, lwid, texth];

        but = uicontrol('style','push','pos',bpos,'string','Go away','call','close');
 
        pbut = uicontrol('style','push','pos',pbpos,'string','Print','call','print',...
			'visible','off');

        cbut = uicontrol('style','push','pos',cbpos,'string','Clear','call','pline(''clearxy'')');
 

elseif strcmp(action,'clearxy')

        Xname = 't';
 
        texth = 24;
        textw = 100;
        figmargin = 15;
        frmargin = 5;
        sep = 30;
        lwid = textw + 10;      % The first guess at the width of the legend.
 
% The absolute position of the t-plot axes
 
        rr = 0.8;
 
        aleft = 73.8;
        abott = 47.2;
        awidth = 434*rr;
        aht =  342*rr;
 
        frsep = (aht - 10*texth-10)/3;
 
% Find the PLINE t-plot figure
 
        fwid1 = aleft + awidth + sep + figmargin;
        fwid = fwid1 + lwid;                            % This may change.
        fht = abott + aht + 32;
 
        pos = get(gcf,'position');
        figpos = [pos(1),pos(2),fwid,fht];

        figs = get(0,'children');
        dfdisp = 0;
        for (figno = 1:length(figs))
                nn = get(figs(figno),'name');
                if (strcmp(nn,'PLINE t-plot'))
                                ppxy = figs(figno);
                end
        end

        figure(ppxy);
	clf
 
% The legend.
 
        lleft = aleft + awidth + sep;
        lbot = abott + frsep*3 + texth*8 +10;
        lpos = [lleft/fwid,lbot/fht,lwid/fwid,2*texth/fht];
 
        leg = axes('pos',lpos,'box','on','drawmode','fast','nextplot','add',...
                'xtick',[-1],'ytick',[-1],'xticklabel','','yticklabel','',...
                'xlim',[0,1],'ylim',[0,1],'clipping','on','visible','off');
 
        set(leg,'user',str2mat('t','x'));
        axes(leg);
        xh = text(0,0,'t','units','norm','visible','off');
        yh = text(0,0,'x','units','norm','visible','off');
        xext = get(xh,'extent');delete(xh);
        yext = get(yh,'extent');delete(yh);
        tw = max(xext(3),yext(3));
 
% The t-plot axes.  This changes with fwid.
 
        alft = aleft/fwid;
        awid = awidth/fwid;
        abot = abott/fht;
        aht = aht/fht;
        apos = [alft,abot,awid,aht];
 
        axy = axes('pos',apos,'box','on','xgrid','on','ygrid','on','next','add',...
                'drawmode','fast');
 	xlabel('t');
	ylabel('x');

% The position of the close button
 
        bbot = abott;
        bwid = lwid;
        bleft = aleft + awidth + sep + (lwid - bwid)/2;
        bpos = [bleft,bbot,bwid,texth];

% The position of the print button.
 
        pbbot = bbot + texth + frsep;
        pbpos = [bleft, pbbot, lwid, texth];
 
% The position of the clear button.
 
        cbbot = bbot + 2*texth + 2*frsep;
        cbpos = [bleft, cbbot, lwid, texth];
 
        but = uicontrol('style','push','pos',bpos,'string','Go away','call','close');
 
        pbut = uicontrol('style','push','pos',pbpos,'string','Print','call','print',...
		'visible','off');
 
        cbut = uicontrol('style','push','pos',cbpos,'string','Clear','call','pline(''clearxy'')');
 

 
elseif strcmp(action,'down')

% 'down' is the Window Button Down call.  It starts the computation of
% solutions from a click of the mouse.

	dh = get(gcf,'user');
	notice = dh(2:3);
	initpt = get(gca,'currentpoint');
	initpt = initpt(1,[1,2]);
	pline('solution',initpt(1));
	

elseif strcmp(action,'solution')

% 'solution' affects the computation and (erasemode == none) plotting of
% solutions.  It also stores the data as appropriate.

	dh = get(gcf,'user');
	dm = get(dh(1),'user');

	notice    = dh(2:3);
	plotspeed = dh(15);
	tol       = dh(16);
	msize     = (dh(17)+2)*5;
	dummy     = dh(18);

	initpt(1) = input1;
	y = input1;

	FFFCCNNN = deblank(dm(2,:));
	Tend = dh(12);
	settings = dh(14:19);
	
	ptstr = [num2str(initpt(1))];

	set(notice(1),'string',...
		['Computing the solution starting at  ',ptstr])
	set(notice(2),'string','');

	drawnow;

	[tp,xp] = odepl(FFFCCNNN,0,Tend,y,tol);

	c = rand(1,3);

	if (dummy ~= 0)
        head = line( ...
        'color',c, ...
        'marker','.', ...
        'markersize',msize, ...
        'erase','xor', ...
        'xdata',y,'ydata',0);
	else
	head = line( ...
        'color',[0,0,0], ...
        'marker','.', ...
        'markersize',msize, ...
        'erase','xor', ...
        'xdata',y,'ydata',0);
	end

	for i=1:size(xp)
		for j=1:400*round(10-plotspeed) 
			h=j; 
		end
		y = xp(i);
        	set(head,'xdata',y,'ydata',0.0)
        	drawnow;
	end

	dh(9) = y;
	dh(24)= tp(length(tp));
	dh(20:22) = c;

	ptstr = [num2str(y)];

        if (abs(y)>10e4)
                dh(18)=1;
                set(notice(1),'string','Solution appears to approach infinity.');
                set(notice(2),'string',['Choose a new initial value.']);
        else
                set(notice(1),'string','Ready.');
                set(notice(2),'string',['Endpoint:  ',ptstr]);
        end

        set(gcf,'user',dh);

        figs = get(0,'children');
        dfdisp = 0;
        for (figno = 1:length(figs))
                nn = get(figs(figno),'name');
                if (strcmp(nn,'PLINE t-plot'))
                                dfdisp = figs(figno);
                                figure(dfdisp);
				plot(tp,xp);
                end
        end

elseif strcmp(action,'kcompute')

% 'kcompute' is the call back for the Compute button on the PLINE Keyboard figure.

	errmsg1 = 'Initial value has not been entered.';
	errmsg2 = 'You must start PLINE from the beginning.';
	kh = get(gcf,'user');
	initpt = [str2num(get(kh(2),'string'))];
	if (length(initpt) ~= 1)
		error(errmsg1);
	end
	figs = get(0,'children');
	dfdisp = 0;
	for (figno = 1:length(figs));
		if (strcmp(get(figs(figno),'name'),'PLINE Display'))
			dfdisp = figs(figno);
		end
	end
	if (dfdisp == 0)
		error(errmsg2);
	else
		figure(dfdisp);
		pline('solution',initpt);
	end

	
elseif strcmp(action,'kbd')

% 'kbd' is the callback for the Keyboard Input menu selection.  It 
% sets up the PLINE Keyboard figure which allows accurate input of 
% initial values using the keyboard.

	dh = get(gcf,'user');
	dm = get(dh(1),'user');
	Xname = deblank(dm(1,:));

	txtl = 149;txth = 18;
	
	dfkbd = figure('pos',[30 200 (txtl+52) (9*txth)],...
		'resize','off','name','PLINE Keyboard input','numb','off');
	figure(dfkbd)
	
	
	KBD(1) = uicontrol('style','text','pos',[1 7*txth txtl txth],...
		'horiz','right','string',['The initial value of ',Xname,' = ']);
		
	KBD(2) = uicontrol('style','edit','pos',[txtl+1 7*txth 50 txth],...
		'string','','call','');
		
	KBD(3) = uicontrol('style','push',...
		'pos',[(txtl+52)/2-35 3*txth 70 txth],...
		'string','Compute','call','pline(''kcompute'')');

	KBD(4) = uicontrol('style','push',...
		'pos',[(txtl+52)/2-35,txth,70,txth],...
		'string','Go away','call','close');
		
	set(dfkbd,'user',KBD);

		
		
elseif strcmp(action,'settings')

% 'settings' is the call back for the Settings menu option.  It sets
% up the PLINE Settings window, which allows the user to interactively
% change several parameters that govern the behavior of the program.
	
	dh = get(gcf,'user');
	settings = dh(14:19);
	Arrflag = settings(1);
	rval1 = ~(Arrflag -1);
	rval2 = (~(Arrflag -2))*2;
	rval3 = (~(Arrflag -3))*3;

	txtl = 350;txth = 18;
	figwidth = txtl+104;
	pbwidth = 80;
	framewidth = 3*pbwidth+2*8+2*10;
	frleft = (figwidth - framewidth)/2;
	frbot = 13*txth-5;
	frpos = [frleft frbot framewidth (txth+10)];
	
	dfsettings = figure('pos',[150 50 figwidth (15*txth)],...
		'resize','off','name','PLINE Settings','numb','off');
	figure(dfsettings)
	
	
	%setframe = uicontrol('style','frame','pos',frpos);
	
	
	call1 =[
		'data = get(gcf,''user'');',...
		'data(2) = min([10,abs(round(str2num(get(data(7),''string''))))]);',...
		'set(gcf,''user'',data);'];
		
	
	settext(1) = uicontrol('style','text','pos',[3 11*txth txtl txth],...
		'horiz','left','string','Plot speed (between 0 (slow) and 10 (fast)):  ');
		
	setedit(1) = uicontrol('style','edit','pos',[3+txtl 11*txth 100 txth],...
		'string',num2str(settings(2)),'call',call1);

	settext(2) = uicontrol('style','text','pos',[3 9*txth txtl txth],...
		'horiz','left','string','Relative error tolerance:  ');
		
	call2 =[
		'data = get(gcf,''user'');',...
		'data(3) = str2num(get(data(8),''string''));',...
		'set(gcf,''user'',data);'];
	
		
	setedit(2) = uicontrol('style','edit','pos',[3+txtl 9*txth 100 txth],...
		'string',num2str(settings(3)),'call',call2);
		
	settext(3) = uicontrol('style','text','pos',[3 7*txth txtl txth],...
		'horiz','left','string','Marker size (between 0 (small) and 10 (big)):  ');

	call3 =[
		'data = get(gcf,''user'');',...
		'data(4) = min([10,abs(round(str2num(get(data(9),''string''))))]);',...
		'set(gcf,''user'',data);'];
		
	setedit(3) = uicontrol('style','edit','pos',[3+txtl 7*txth 100 txth],...
		'string',num2str(settings(4)),'call',call3);

	settext(4) = uicontrol('style','text','pos',[3 5*txth txtl txth],...
		'horiz','left','string','Color marker (0 (No) and 1(Yes))?  ');

	call4 =[
		'data = get(gcf,''user'');',...
		'data(5) = round(str2num(get(data(10),''string'')));',...
		'set(gcf,''user'',data);'];
		
	setedit(4) = uicontrol('style','edit','pos',[3+txtl 5*txth 100 txth],...
		'string',num2str(settings(5)),'call',call4);

	bwidth = 130;
	spacing = (figwidth-2*bwidth-6)/3;
		
	setbutt(1) = uicontrol('style','push','pos',[3+spacing,txth,bwidth,txth],...
		'string','Cancel','call','close');
	
	setbutt(2) = uicontrol('style','push','pos',[3+2*spacing+bwidth,txth,bwidth,txth],...
		'string','Change settings','call','pline(''setchange'')');
		
	set(dfsettings,'user',[settings,setedit]);

elseif strcmp(action,'setchange')

% 'setchange' is the callback for the Change button on the PLINE Settings window.

	flag = 0;
	data = get(gcf,'user');
	settings = data(1:6);
	dfdisp = 0;
	figs = get(0,'children');
	for (figno = 1:length(figs));
		if (strcmp(get(figs(figno),'name'),'PLINE Display')),
			dfdisp = figs(figno);
		end
	end
	if (dfdisp == 0)
		error('You must start PLINE from the beginning.');
	else
		dh = get(dfdisp,'user');
		dh(14:19) = settings;
		set(dfdisp,'user',dh);
	end
	dfset = 0;
	for (figno = 1:length(figs));
		if (strcmp(get(figs(figno),'name'),'PLINE Setup'))
			dfset = figs(figno);
		end
	end
	if (dfset == 0)
		error('You must start PLINE from the beginning.');
	else
		sh = get(dfset,'user');
		sh(29:34) = settings;
		set(dfset,'user',sh);
	end
	close
	
elseif strcmp(action,'text')

  dh = get(gcf,'user');

  pldisp = gcf;
  oldcall = get(pldisp,'WindowButtonDownFcn');
  set(pldisp,'WindowButtonDownFcn','');
  prompt = ['Enter the text here. Then choose ',...
        'the location in the Display Window.'];
  txtstr = inputdlg(prompt,'Text entry');
  if ~isempty(txtstr)
    txtstr = txtstr{1};
    figure(pldisp);
    gtext(txtstr);
  end
  set(pldisp,'WindowButtonDownFcn',oldcall);


elseif strcmp(action,'continue')

% 'continue' 

        dh = get(gcf,'user');
        dm = get(dh(1),'user');

	notice    = dh(2:3);
	plotspeed = dh(15);
	tol       = dh(16);
	msize     = (dh(17)+2)*5;
	dummy     = dh(18);

	if (dh(19) == 1)
		set(notice(1),'string',...
                ['The solution already diverged to infinity.'])
        	set(notice(2),'string',['Please, choose a new initial value.']);
	else
        y = dh(9);
	ti = dh(24);
	c = dh(20:22);

        FFFCCNNN = deblank(dm(2,:));
        Tend = dh(12);
        settings = dh(14:19);

        ptstr = [num2str(y)];

        set(notice(1),'string',...
                ['Computing the solution starting at  ',ptstr])
        set(notice(2),'string','');

        drawnow;

	Tend = ti+Tend;
        [tp,xp] = odepl(FFFCCNNN,ti,Tend,y,tol);

	if (dummy ~=0)
        head = line( ...
        'color',c, ...
        'marker','.', ...
        'markersize',msize, ...
        'erase','xor', ...
        'xdata',y,'ydata',0);
	else
	head = line( ...
        'color',[0,0,0], ...
        'marker','.', ...
        'markersize',msize, ...
        'erase','xor', ...
        'xdata',y,'ydata',0);
	end

	set(head,'xdata',xp(1),'ydata',0.0)
	drawnow;

        for i=1:size(xp)
		for j=1:400*round(10-plotspeed) 
			h=j; 
		end
                y = xp(i);
                set(head,'xdata',y,'ydata',0.0)
                drawnow;
        end

        dh(9) = y;
        dh(24)= tp(length(tp));
 
        ptstr = [num2str(y)];
 
        if (abs(y)>10e4)
                dh(18)=1;
                set(notice(1),'string','Solution appears to approach infinity.');
                set(notice(2),'string',['Choose a new initial value.']);
        else
                set(notice(1),'string','Ready.');
                set(notice(2),'string',['Endpoint:  ',ptstr]);
        end
 
        set(gcf,'user',dh);

        figs = get(0,'children');
        dfdisp = 0;
        for (figno = 1:length(figs))
                nn = get(figs(figno),'name');
                if (strcmp(nn,'PLINE t-plot'))
                                dfdisp = figs(figno);
                                figure(dfdisp);
                                plot(tp,xp);
                end
        end
	end

elseif strcmp(action,'goaway')

        figs = get(0,'children');
        dfdisp = 0;
        for (figno = 1:length(figs))
                nn = get(figs(figno),'name');
                if (length(nn) > 1)
                        if (strcmp(nn,'PLINE Display'))
                                dfdisp = figs(figno);
                                dh = get(dfdisp,'user');
                                dm = get(dh(1),'user');
                                FFFCCNNN = deblank(dm(2,:));
                        if (exist(FFFCCNNN)==2) delete([FFFCCNNN,'.m']); end
                                close(dfdisp)
                end
        end
end

elseif strcmp(action,'quit')

% 'quit' is the callback of the Quit buttons on teh PLINE Setup and PLINE
% Display windows.  It provides for an orderly exit, deleting all
% associated windows and the function m-file.

	figs = get(0,'children');
	dfdisp = 0;
	for (figno = 1:length(figs))
		nn = get(figs(figno),'name');
		if (length(nn) > 1)
			if (strcmp(nn,'PLINE Display'))
				dfdisp = figs(figno);
				dh = get(dfdisp,'user');
				dm = get(dh(1),'user');
				FFFCCNNN = deblank(dm(2,:));
				if (exist(FFFCCNNN)==2) delete([FFFCCNNN,'.m']); end
				close(dfdisp)
			elseif (~isempty(findstr(nn,'PLINE')))
				close(figs(figno))		
			end
		end
	end
end
