function wav = helperDesignFMCWWaveform(c,lambda)
% This function helperDesignFMCWWaveform is only in support of
% MIMORadarVirtualArrayExample. It may change in a future release.

% Copyright 2017 The MathWorks, Inc.

%sweeptime = (9.787 - 3.8)e-6;
range_max = 150; %300m target
%The sweep time can be computed based on the time needed for the signal to 
% travel the unambiguous maximum range. In general, for an FMCW radar 
% system, the sweep time should be at least five to six times the round 
% trip time. This example uses a factor of 5.5.
%tm = 6*range2time(range_max,c);
tm = 6e-6;

range_res =14.0625;  %0.3 target
%range_res =3;  
bw = rangeres2bw(range_res,c);
sweep_slope = bw/tm;
fr_max = range2beat(range_max,sweep_slope,c);

v_max = 230*1000/3600;
fd_max = speed2dop(2*v_max,lambda);

fb_max = fr_max+fd_max;
fs = max(2*fb_max,bw);
%fs = 2*fb_max;
%fs = 2*fb_max;
%fs = 10e6;
%bwm = 80e6;
%sweep_time = 6.4e-6;
wav = phased.FMCWWaveform('SweepTime',tm,'SweepBandwidth',bw,...
    'SampleRate',fs);
