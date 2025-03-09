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
%       Calculates square roots using Heron's method.                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Author:     Ryan Maguire                                                   %
%   Date:       March 9, 2025.                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Function:                                                                  %
%       herons_method                                                          %
%   Purpose:                                                                   %
%       Computes square roots of positive real numbers using Heron's method.   %
%   Arguments:                                                                 %
%       x (real):                                                              %
%           A positive real number, the input to the square root function.     %
%   Output:                                                                    %
%       sqrt_x (real):                                                         %
%           The square root of the input.                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function approximate_root = herons_method(x)

    % Heron's method is iterative and the convergence is quadratic. This
    % means that if a_{n} has N correct decimals, then a_{n+1} will have
    % 2N correct decimals. A standard 64-bit double can fit about 16
    % decimals of precision (the exact value is 2^-52 ~= 2.22x10^-16).
    % Because of this we may exit the function after a few iterations.
    maximum_number_of_iterations = 16;

    % The maximum allowed error. This is double precision epsilon.
    epsilon = 2.220446049250313E-16;

    % Set the initial guess to the input. Provided x is positive, Heron's
    % method will indeed converge.
    approximate_root = x;

    % Iteratively apply Heron's method.
    for _ = 1:maximum_number_of_iterations

        % If the error is small we can break out of this for-loop. Check.
        error = (x - approximate_root * approximate_root) / x;

        if abs(error) <= epsilon
            break;
        end

        % Otherwise improve the approximation using Heron's method.
        approximate_root = 0.5 * (approximate_root + x / approximate_root);

    end

end

x = 2.0;
sqrt_x = herons_method(x);

printf("sqrt(%.1f) = %.16f\n", x, sqrt_x);
