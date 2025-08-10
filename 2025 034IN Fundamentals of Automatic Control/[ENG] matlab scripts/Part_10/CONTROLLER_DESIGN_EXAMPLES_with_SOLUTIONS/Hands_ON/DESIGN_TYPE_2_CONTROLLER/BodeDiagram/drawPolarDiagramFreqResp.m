function [haxPoDiag] = drawPolarDiagramFreqResp(Gs, ...
    omega_values, polar_color, polar_line_width, polar_line_style,...
    markerSize, om_selected, fig_handler, legendFLAG)
%  drawPolarDiagramFreqResp( )
%  Plotting polar diagrams of the frequency response 
%  of continuous-time transfer functions. 
%
% INPUT variables:
% Gs: transfer function, described as TF object; MANDATORY variable
%
% omega_values: angular frequency values used to draw the graphs 
%               (OPTIONAL - if not present, a suitable frequency range 
%                is estimated).
% 
% polar_color: colour of actual graphs 
%             (array: three values between 0 and 1) - OPTIONAL
%               Default value: [0, 0, 1] <--> blue
%
% polar_line_width: line thickness for actual graphs - OPTIONAL
%               Default value: 2.0
%
% polar_line_style: line style for actual diagrams 
%                  (see 'LineStyle' in plot( ) ) - OPTIONAL
%                  Default value: '-' 
%
% markerSize: is the size (in pt.) of the circular markers used 
%             to put in evidence the points in the polar draw 
%             corresponding to null angular frequency and 
%             frequency going to infinity. If empty or zero, no markers
%             will be drawn at all.  - OPTIONAL
%             Default value: 6 
%
% om_selected: some angular frequency values at which you want to place 
%              a circular marker (black) in the graph.  - OPTIONAL
%              Default value: empty array 
%
% fig_handler: The figure handler of a figure already in use, 
%              where the polar diagram has to be drawn.    
%              If it does not exist, a new figure is created.
%
% legendFLAG: a logical flag; if true an automatic legend will be inserted
%             in the plot; otherwise, no legend will appear.
% ----------
% OUTPUT variable (optional): the handler of the axes
% corresponding to the plot.

if (nargin < 1)
    error('drawPolarDiagramFreqResp: the var ''Gs'' is MANDATORY!');
else
    DEFAULT_polar_color        = [0,0,1];
    DEFAULT_polar_line_width   = 1.5;
    DEFAULT_polar_line_style   = '-';
    DEFAULT_markerSize = 6;
    DEFAULT_om_selected = [];
    DEFAULT_hf = [];
    DEFAULT_legendFLAG = false;
end % if 

switch nargin
    case 1
        omega_values = [];
        polar_color = DEFAULT_polar_color;
        polar_line_width = DEFAULT_polar_line_width;
        polar_line_style = DEFAULT_polar_line_style;
        markerSize = DEFAULT_markerSize;
        om_selected = DEFAULT_om_selected;
        fig_handler = DEFAULT_hf;
        legendFLAG = DEFAULT_legendFLAG;
    case 2
        polar_color = DEFAULT_polar_color;
        polar_line_width = DEFAULT_polar_line_width;
        polar_line_style = DEFAULT_polar_line_style;
        markerSize = DEFAULT_markerSize;
        om_selected = DEFAULT_om_selected;
        fig_handler = DEFAULT_hf;
        legendFLAG = DEFAULT_legendFLAG;
    case 3
        polar_line_width = DEFAULT_polar_line_width;
        polar_line_style = DEFAULT_polar_line_style;
        markerSize = DEFAULT_markerSize;
        om_selected = DEFAULT_om_selected;
        fig_handler = DEFAULT_hf;   
        legendFLAG = DEFAULT_legendFLAG;
    case 4
        polar_line_style = DEFAULT_polar_line_style;
        markerSize = DEFAULT_markerSize;
        om_selected = DEFAULT_om_selected;
        fig_handler = DEFAULT_hf; 
        legendFLAG = DEFAULT_legendFLAG;
    case 5
        markerSize = DEFAULT_markerSize;
        om_selected = DEFAULT_om_selected;
        fig_handler = DEFAULT_hf; 
        legendFLAG = DEFAULT_legendFLAG;
        
    case 6
        om_selected = DEFAULT_om_selected;
        fig_handler = DEFAULT_hf;
        legendFLAG = DEFAULT_legendFLAG;
        
    case 7
        fig_handler = DEFAULT_hf;
        legendFLAG = DEFAULT_legendFLAG;
    case 8
        legendFLAG = DEFAULT_legendFLAG;
    case 9
        % nothing
end % switch

% ----- compute the frequency response -------------
if min(omega_values)>0
    omega_values = [0; omega_values(:)];
end % if

if ~isempty(om_selected)
    omega_values = sort([omega_values; om_selected(:)]);
    [Rmarks, Imarks] = nyquist(Gs, om_selected);
end

[ReFR_R, ImFR_R, om_vals] = nyquist(Gs, omega_values);
ReFR_R = reshape(ReFR_R, 1, numel(ReFR_R));
ImFR_R = reshape(ImFR_R, 1, numel(ImFR_R));
if isempty(omega_values)
    omega_values = om_vals;
end % if
% ------------------------------------------------

if isempty(fig_handler)
    figure;
else
    figure(fig_handler);
end

q = plot(ReFR_R(:), ImFR_R(:));
q.Color = polar_color;
q.LineStyle = polar_line_style;
q.LineWidth = polar_line_width;
hold on; 
if and(~isempty(markerSize), (markerSize~=0))
    plot(ReFR_R(1), ImFR_R(1), ...
        'Marker','o','MarkerEdgeColor','g', ...
         'MarkerFaceColor','g', 'MarkerSize',markerSize,...
         'LineStyle','none');
    plot(ReFR_R(end), ImFR_R(end), ...
        'Marker','o','MarkerEdgeColor','r', ...
         'MarkerFaceColor','r', 'MarkerSize',markerSize, ...
         'LineStyle','none');
end % if
if ~isempty(om_selected)
    plot(Rmarks, Imarks, ...
        'Marker','o','MarkerEdgeColor','k', ...
         'MarkerFaceColor','k', 'MarkerSize',markerSize,...
         'LineStyle','none');
end

grid on; % zoom on;
xlabel('Re $G(j \omega)$',...
    'Interpreter', 'latex', 'FontSize',16);
ylabel('Im $G(j \omega)$',...
    'Interpreter', 'latex', 'FontSize',16);
xab = xlim;
yab = ylim;

if (max(ReFR_R) == xab(2))
    newxb = 1.1*xab(2);
else
    newxb = xab(2);
end
if (min(ReFR_R) == xab(1))
    newxa = 0.9*xab(1);
else
    newxa = xab(1);
end
xlim([newxa, newxb]);

if (max(ImFR_R) == yab(2))
    if (yab(2)~=0)
        newyb = 1.1*yab(2);
    else
        newyb = 1.0;
    end
else
    newyb = yab(2);
end
if (min(ImFR_R) == yab(1))
    newya = 0.9*yab(1);
else
    newya = yab(1);
end
xlim([newxa, newxb]);
ylim([newya, newyb]);

if legendFLAG
    if isempty(om_selected)
        legend('$G(j \omega)$', '$\omega = 0$',...
            '$\omega \to \infty$', ...
                'Interpreter', 'latex', 'Fontsize', 14, ...
                'Location', 'best')
    else
        legend('$G(j \omega)$', '$\omega = 0$',...
            '$\omega \to \infty$', '',...
                'Interpreter', 'latex', 'Fontsize', 14, ...
                'Location', 'best')

    end
end
if (nargout >0)
    haxPoDiag  = gca;
end
