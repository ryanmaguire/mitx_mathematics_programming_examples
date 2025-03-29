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
%       Calculates roots of a function using bisection.                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Author:     Ryan Maguire                                                   %
%   Date:       March 29, 2025.                                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Function:                                                                  %
%       bisection                                                              %
%   Purpose:                                                                   %
%       Computes the root of a function f between a and b.                     %
%   Arguments:                                                                 %
%       f (function):                                                          %
%           A function f: R -> R. The root of f is computed.                   %
%       a (real):                                                              %
%           One of the endpoints of the interval for f.                        %
%       b (real):                                                              %
%           The other endpoint for f.                                          %
%   Output:                                                                    %
%       root (real):                                                           %
%           A root of the function f between a and b.                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function root = bisection(f, a, b)

    % Tell the algorithm to stop after several iterations to avoid an
    % infinite loop. Double precision numbers have 52 bits in the mantissa,
    % mean if |b - a| ~= 1, after 52 iterations of bisection we will get as
    % close as we can to the root. To allow for |b - a| to be larger, halt
    % the algorithm after at most 64 steps.
    maximum_number_of_iterations = 64;

    % The maximum allowed error. This is double precision epsilon.
    epsilon = 2.220446049250313E-16;

    % Evaluate f at the two endpoints to determine which is positive and
    % which is negative. We transform [a, b] to [left, right] by doing this.
    a_eval = f(a);
    b_eval = f(b);

    % Rare case, f(a) = 0. Return a, no bisection needed.
    if a_eval == 0.0
        root = a;
        return;
    end

    % Similarly, if f(b) = 0, then we have already found the root. Return b.
    if b_eval == 0.0
        root = b;
        return;
    end

    % Compare the two evaluations and set left and right accordingly.
    if a_eval < b_eval

        % If both evaluations are negative, or if both are positive, then
        % the bisection method will not work. Return NaN.
        if b_eval < 0.0 || a_eval > 0.0
            root = (a - a) / (a - a);
            return;
        end

        % Otherwise, since f(a) < f(b), set left = a and right = b.
        left = a;
        right = b;

    % In this case the function starts positive and tends to a negative.
    else

        % Same sanity check as before. We need one evaluation to be
        % negative and one to be positive. Abort if both have the same sign.
        if a_eval < 0.0 || b_eval > 0.0
            root = (a - a) / (a - a);
            return;
        end

        % Since f(a) > f(b), set left = b and right = a.
        left = b;
        right = a;

    end

    % Start the bisection method. Compute the midpoint of a and b.
    midpoint = 0.5 * (a + b);

    % Iteratively apply Heron's method.
    for _ = 1:maximum_number_of_iterations

        % If f(x) is very small, we are close to a root and can break out
        % of this for loop. Check for this.
        f_eval = f(midpoint);

        if abs(f_eval) <= epsilon
            break;
        end

        % Apply bisection to get a better approximation for the root. We
        % have f(left) < 0 < f(right). If f(midpoint) < 0, replace the
        % interval [left, right] with [midpoint, right]. Set left to the
        % midpoint and reset the midpoint to be closer to right.
        if f_eval < 0.0
            left = midpoint;
            midpoint = 0.5 * (midpoint + right);

        % In the other case, f(midpoint) > 0, we replace right with the
        % midpoint, changing [left, right] into [left, midpoint]. We then
        % set the midpoint to be closer to left.
        else
            right = midpoint;
            midpoint = 0.5 * (left + midpoint);
        end

    end

    % After n iterations, we are no more than |b - a| / 2^n away from the
    % root of the function. 1 / 2^n goes to zero very quickly, meaning the
    % convergence is very quick.
    root = midpoint;

end

% pi is somewhere between 3 and 4, and it is a root to sine.
a = 3.0;
b = 4.0;

% Compute pi using bisection. We should get pi = 3.14159..., accurate
% to about 16 decimals.
pi_by_bisection = bisection(@sin, a, b);
printf("pi = %.16f\n", pi_by_bisection);
