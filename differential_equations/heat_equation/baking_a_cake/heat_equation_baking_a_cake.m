%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                   LICENSE                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This file is part of mitx_mathematics_programming_examples.                %
%                                                                              %
%   mitx_mathematics_programming_examples is free software: you can            %
%   redistribute it and/or modify it under the terms of the GNU General Public %
%   License as published by the Free Software Foundation, either version 3 of  %
%   the License, or (at your option) any later version.                        %
%                                                                              %
%   mitx_mathematics_programming_examples is distributed in the hope that it   %
%   will be useful, but WITHOUT ANY WARRANTY; without even the implied         %
%   warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the  %
%   GNU General Public License for more details.                               %
%                                                                              %
%   You should have received a copy of the GNU General Public License          %
%   along with mitx_mathematics_programming_examples.  If not, see             %
%   <https://www.gnu.org/licenses/>.                                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Purpose:                                                                   %
%       Numerical solver for the heat equation applied to baking a cake.       %
%   Notes:                                                                     %
%       This is an adaptation of the original MATLAB code written by the MITx  %
%       team some years ago. I have re-written everything so that it works on  %
%       GNU Octave, so users need not rely on MATLAB.                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Author:     Ryan Maguire                                                   %
%   Date:       Nevember 4, 2024.                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Solve heat equation using forward time, centered space scheme.
close all;
clearvars;

% Parameters for the spatial grid.
length_of_cake = 0.1;
number_of_steps = 20;

% Time step used in the numerical solver.
dt = 0.06;

% Time parameter for the simulation.
max_time = 60.0;

% Create an array for the time axis.
time = 0.0:dt:max_time;

% And create an array for the spacial component.
x = linspace(0.0, length_of_cake, number_of_steps);

% Displacement. This is the length of the cake divided by the number of steps.
dx = x(2) - x(1);

% Pre-compute the scale factors to save on redundant calculations.
dx_sq = dx*dx;
two_dx_sq = 2.0 * dx_sq;

% Initial condition.
initial_conditions = @(x) 20 * ones(1, 20);

% Parameters for the time and spatial components of the for-loops below.
number_of_time_steps = length(time);
number_of_spatial_steps = number_of_steps - 1;

% Set the initial conditions for the cake.
u = initial_conditions(x);
u(1) = 200;
u(end) = u(end - 1);

% Conductivity.
k = @(u) ((0.19 - 0.31)*0.5) * erf(u-100) + (0.31 - 0.19)*0.5 + 0.19;

% Capacity.
c = @(u) ((2200.0 - 2800.0)*0.5) * erf(u-100) + (2800.0 - 2200.0)*0.52 + 2200.0;

% Loop through both the time and spatial compents and numerically solve.
for i = 1:number_of_time_steps

    % Impose left boundary condition.
    u(i + 1, 1) = 200;

    for j = 2:number_of_spatial_steps

        % Find solution at next time step.
        denom = two_dx_sq * c(u(i, j));
        factor = dt / denom;

        % Centered spatial component, numerical solver. We have, for the
        % heat equation, the following setup:
        %   u_xx = u_t
        % Applying an Euler-like numerical solver, we get:
        %   u(i+1, j) = dt u_xx(i, j)
        % We numerically compute u_xx using the centered difference calculation.
        % We need u(i, j), u(i, j-1), and u(i, j+1) for this. Compute.
        u_j_plus_1 = u(i, j + 1);
        u_j = u(i, j);
        u_j_minus_1 = u(i, j - 1);

        % Compute the sums from the centered difference scheme.
        right_sum = u_j_plus_1 + u_j;
        left_sum = u_j_minus_1 + u_j;
        right = k(right_sum) * u_j_plus_1;
        left = k(left_sum) * u_j_minus_1;
        center = (k(u_j_plus_1) + 2.0 * k(u_j) + k(u_j_minus_1)) * u_j;

        % Numerically calculate the next step.
        u(i + 1, j) = u(i, j) + factor * (right + left - center);

    end

    % Impose right boundary condition.
    u(i + 1, end) = u(i + 1, end - 1);

    % Create the animation
    % First time through the main loop, create the plot
    % Subsequent times, update YData and title
    if i == 1

        % Plot solution.
        p = plot(x, u(i, :), 'linewidth', 2);
        xlabel('$x$', 'interpreter', 'latex')
        ylabel('$u$', 'interpreter', 'latex')
        ylim([20, 200]);
    else

        % Update the plot.
        set(p, 'YData', u(i, :));
    end

    title(['t = ', num2str(time(i), '%.3f')], 'interpreter', 'latex')

    drawnow

end
