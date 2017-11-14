function H = ppstart

% PPSTART is a function m-file that is read when PPLANE5 
%         is started and which inputs certain data that 
%         are used to change defaults.  Only three items 
%         allowed.  If only one item is to be changed, all 
%         three should be included.  The following are the 
%         defaults as written in PPLANE5, and changes can 
%         be made as needed.

%  THIS IS THE MACINTOSH VERSION!


H.style = 'white';	% Must be 'white' or 'black'.

H.size = 12;			% Any number is allowed.  This is the 
                     % main font size used in PPLANE5.  It 
                     % determines the size of all windows,
                     % and everything else.

matlabroot_path = matlabroot;
if (matlabroot_path(length(matlabroot_path)) ~= ':')
  matlabroot_path = [ matlabroot_path, ':' ];
end

helpdir = [ matlabroot, 'toolbox:laode' ];		

H.ppdir = [ matlabroot_path, 'toolbox:laode' ];






% The directory where systems and 
% galleries are to be found.  This must be 
% a string like:
%    'Macintosh HD:toolbox:laode'

