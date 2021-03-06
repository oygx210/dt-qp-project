%--------------------------------------------------------------------------
% SecondOrderSingular_output.m
% Output function for SecondOrderSingular example
%--------------------------------------------------------------------------
%
%--------------------------------------------------------------------------
% Primary contributor: Daniel R. Herber (danielrherber on GitHub)
% Link: https://github.com/danielrherber/dt-qp-project
%--------------------------------------------------------------------------
function [O,sol] = SecondOrderSingular_output(T,U,Y,P,F,in,opts)

% solution on T
sol(2).T = T;
sol(1).U = SecondOrderSingular_U(T);
sol(1).Y = SecondOrderSingular_Y(T);
sol(1).F = SecondOrderSingular_F;

% solution on high resolution T
if opts.general.plotflag
    sol(2).T = linspace(0,T(end),1e4)';
    sol(2).U = SecondOrderSingular_U(sol(2).T);
    sol(2).Y = SecondOrderSingular_Y(sol(2).T);
    sol(2).F = SecondOrderSingular_F;
end

% errors
errorU = abs(U-sol(1).U);
errorY = abs(Y-sol(1).Y);
errorF = abs(F-sol(1).F);

% outputs
O(1).value = max(errorU,[],'all');
O(1).label = 'Umax';
O(2).value = max(errorY,[],'all');
O(2).label = 'Ymax';
O(3).value = max(errorF);
O(3).label = 'F';
O(4).value = max(in.QPcreatetime);
O(4).label = 'QPcreatetime';
O(5).value = max(in.QPsolvetime);
O(5).label = 'QPsolvetime';

end