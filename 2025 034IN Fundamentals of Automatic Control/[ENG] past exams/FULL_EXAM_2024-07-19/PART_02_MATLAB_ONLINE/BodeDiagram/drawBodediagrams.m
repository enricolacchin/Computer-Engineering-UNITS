function [haxMAG, haxPH] = drawBodediagrams(Gs, ...
    omega_values, asBode_color, ...
    asBode_line_width, asBode_line_style ,...
    bode_color, bode_line_width, bode_line_style,...
    fig_handler, comp_asympt_vs_actual_ph_diagrsFLAG)
%  drawBodediagrams( )
%  Plotting Bode diagrams of the frequency response 
% (asymptotic and actual superimposed diagrams) of 
% continuous-time transfer functions. 
%
% INPUT variables:
% Gs: transfer function, described as TF object; MANDATORY variable
%
% omega_values: angular frequency values used to draw the graphs 
%               (OPTIONAL - if not present, a suitable frequency range 
%                is estimated on the basis of zeros and poles. An 
%                appropriate number of values for the angular pulsation 
%                in the newly determined range is then chosen).
%
% asBode_color: colour of asymptotic graphs 
%               (array: three values between 0 and 1) - OPTIONAL
%               Default value: [1, 0, 0] <--> red
%
% asBode_line_width: line thickness for asymptotic graphs - OPTIONAL
%               Default value: 2 
%
% asBode_line_style: line style for asymptotic diagrams 
%                    (see 'LineStyle' in plot( ) ) - OPTIONAL
%              Default value: '-' 
% 
% bode_color: colour of actual graphs 
%             (array: three values between 0 and 1) - OPTIONAL
%               Default value: [0, 0, 1] <--> blue
%
% bode_line_width: line thickness for actual graphs - OPTIONAL
%               Default value: 1.5
%
% bode_line_style: line style for actual diagrams 
%                  (see 'LineStyle' in plot( ) ) - OPTIONAL
%                  Default value: '-' 
%
% fig_handler: The figure handler of a figure already in use, 
%              where Bode diagrams are drawn.    
%              If it does not exist, a new figure is created.
%
% comp_asympt_vs_actual_ph_diagrsFLAG: 
%       a logic flag indicating whether the 360-degree jump 
%       between the asymptotic phase diagram and the actual 
%       phase diagram should be compensated (if present).
% ----------
% OUTPUT variables (optional): the handlers of the couple of axes
% corresponding to the two subplots.

if (nargin < 1)
    error('drawBodediagrams: the var ''Gs'' is MANDATORY!');
else
    DEFAULT_asBode_color      = [1,0,0];
    DEFAULT_asBode_line_width = 2.0;
    DEFAULT_asBode_line_style = '-';
    DEFAULT_bode_color        = [0,0,1];
    DEFAULT_bode_line_width   = 1.5;
    DEFAULT_bode_line_style   = '-';
    DEFAULT_hf = [];
    DEFAULT_comp_asympt_vs_actual_ph_diagrsFLAG = false;
end % if 

switch nargin
    case 1
        omega_values = [];
        asBode_color = DEFAULT_asBode_color;
        asBode_line_width = DEFAULT_asBode_line_width;
        asBode_line_style = DEFAULT_asBode_line_style;
        bode_color = DEFAULT_bode_color;
        bode_line_width = DEFAULT_bode_line_width;
        bode_line_style = DEFAULT_bode_line_style;
        fig_handler = DEFAULT_hf;
        comp_asympt_vs_actual_ph_diagrsFLAG = ...
                    DEFAULT_comp_asympt_vs_actual_ph_diagrsFLAG; 
    case 2
        asBode_color = DEFAULT_asBode_color;
        asBode_line_width = DEFAULT_asBode_line_width;
        asBode_line_style = DEFAULT_asBode_line_style;
        bode_color = DEFAULT_bode_color;
        bode_line_width = DEFAULT_bode_line_width;
        bode_line_style = DEFAULT_bode_line_style;
        fig_handler = DEFAULT_hf;
        comp_asympt_vs_actual_ph_diagrsFLAG = ...
                    DEFAULT_comp_asympt_vs_actual_ph_diagrsFLAG;
    case 3
        asBode_line_width = DEFAULT_asBode_line_width;
        asBode_line_style = DEFAULT_asBode_line_style;
        bode_color = DEFAULT_bode_color;
        bode_line_width = DEFAULT_bode_line_width;
        bode_line_style = DEFAULT_bode_line_style;
        fig_handler = DEFAULT_hf;      
        comp_asympt_vs_actual_ph_diagrsFLAG = ...
                    DEFAULT_comp_asympt_vs_actual_ph_diagrsFLAG;
    case 4
        asBode_line_style = DEFAULT_asBode_line_style;
        bode_color = DEFAULT_bode_color;
        bode_line_width = DEFAULT_bode_line_width;
        bode_line_style = DEFAULT_bode_line_style;
        fig_handler = DEFAULT_hf; 
        comp_asympt_vs_actual_ph_diagrsFLAG = ...
                    DEFAULT_comp_asympt_vs_actual_ph_diagrsFLAG;
    case 5
        bode_color = DEFAULT_bode_color;
        bode_line_width = DEFAULT_bode_line_width;
        bode_line_style = DEFAULT_bode_line_style;
        fig_handler = DEFAULT_hf; 
        comp_asympt_vs_actual_ph_diagrsFLAG = ...
                    DEFAULT_comp_asympt_vs_actual_ph_diagrsFLAG;

    case 6
        bode_line_width = DEFAULT_bode_line_width;
        bode_line_style = DEFAULT_bode_line_style;
        fig_handler = DEFAULT_hf;
        comp_asympt_vs_actual_ph_diagrsFLAG = ...
                    DEFAULT_comp_asympt_vs_actual_ph_diagrsFLAG;
    case 7
        bode_line_style = DEFAULT_bode_line_style;
        fig_handler = DEFAULT_hf;
        comp_asympt_vs_actual_ph_diagrsFLAG = ...
                    DEFAULT_comp_asympt_vs_actual_ph_diagrsFLAG;
    case 8 
        fig_handler = DEFAULT_hf;
        comp_asympt_vs_actual_ph_diagrsFLAG = ...
                    DEFAULT_comp_asympt_vs_actual_ph_diagrsFLAG;
    case 9
        comp_asympt_vs_actual_ph_diagrsFLAG = ...
                    DEFAULT_comp_asympt_vs_actual_ph_diagrsFLAG;
        % nothing else to do
end % switch

% ----- compute the asymptotic diagrams ----------
[asM, asPhi, omega_values] = asympt_bode(Gs, omega_values); 
% ----- and then the actual diagrams -------------
[M, Phi] = bode(Gs, omega_values); % for a better result, use the
                                   % same angular frequency values 
                                   % as in the asymptotic diagrams
% ------------------------------------------------

% check if a phase compensation is requested
if comp_asympt_vs_actual_ph_diagrsFLAG
    asPhiINIT = asPhi(1);
    PhiINIT = Phi(1);
    Threshold2PIerr = 10; % i.e. approx 0.0175 rad
    PhaseJump = asPhiINIT-PhiINIT;
    if (360-abs(PhaseJump)<=Threshold2PIerr)
        % the asymptotic and actual phase diagrams
        % are precisely 360 degrees apart
        if (PhaseJump>0)
            Phi = Phi + 360;
        else
            Phi = Phi-360;
        end % if
    end % if 
end % if
                                   
asM_dB = 20*log10(asM);
M_dB = 20*log10(M);

if isempty(fig_handler)
    figure;
else
    figure(fig_handler);
end

% % figure;

hsbp1 = subplot(2,1,1);
p = semilogx(omega_values, asM_dB);
p.Color = asBode_color;
p.LineStyle = asBode_line_style;
p.LineWidth = asBode_line_width;
hold on;

q = semilogx(omega_values, M_dB(:));
q.Color = bode_color;
q.LineStyle = bode_line_style;
q.LineWidth = bode_line_width;

grid on; % zoom on;
xlabel('angular frequency [rad/s]');
ylabel('magnitude [dB]');

hsbp2 = subplot(2,1,2);
pf = semilogx(omega_values, asPhi);
pf.Color = asBode_color;
pf.LineStyle = asBode_line_style;
pf.LineWidth = asBode_line_width;
hold on;

qf = semilogx(omega_values, Phi(:));
qf.Color = bode_color;
qf.LineStyle = bode_line_style;
qf.LineWidth = bode_line_width;

grid on; % zoom on;
xlabel('angular frequency [rad/s]');
ylabel('phase [deg]');

linkaxes([hsbp1, hsbp2], 'x');

if (nargout ==2)
    haxMAG = hsbp1;
    haxPH  = hsbp2;
end
