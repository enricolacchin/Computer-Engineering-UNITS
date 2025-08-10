function [MagData,...
           PhaseData,...
           out_om_v] = asympt_bode(SISOmodel, om_vector)
% *** asympt_bode(SISOmodel, om_vector) ***
% [MagData,PhaseData,out_om_v] = asympt_bode(SISOmodel, om_vector)
%
% Asymptotic Bode diagram of a transfer function.%
% The SISOmodel can be any of the available LTI system models, 
% i.e. a tf object (preferred), an ss object or a zpk object.  
% In the event that SISOmodel is not a tf object, it is converted to tf.
%
% om_vector -->  angular frequency values used to draw the graphs 
%               (OPTIONAL - if not present, a suitable frequency range 
%                is estimated on the basis of zeros and poles. An 
%                appropriate number of values for the angular pulsation 
%                in the newly determined range is then chosen).
%
% If MagData and PhaseData vectors are not requested in the output,
% asymptotic modulus and phase graphs are plotted in graphs 
% on a semi-logarithmic scale.
% The array out_om_v contains the angular frequency values 
% used to compute the asymptotic diagram of the frequency response.
% ----------------------------------------------