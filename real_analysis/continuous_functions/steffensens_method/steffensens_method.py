"""
################################################################################
#                                   LICENSE                                    #
################################################################################
#   This file is part of mitx_mathematics_programming_examples.                #
#                                                                              #
#   mitx_mathematics_programming_examples is free software: you can            #
#   redistribute it and/or modify it under the terms of the GNU General Public #
#   License as published by the Free Software Foundation, either version 3 of  #
#   the License, or (at your option) any later version.                        #
#                                                                              #
#   mitx_mathematics_programming_examples is distributed in the hope that it   #
#   will be useful, but WITHOUT ANY WARRANTY; without even the implied         #
#   warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the  #
#   GNU General Public License for more details.                               #
#                                                                              #
#   You should have received a copy of the GNU General Public License          #
#   along with mitx_mathematics_programming_examples.  If not, see             #
#   <https://www.gnu.org/licenses/>.                                           #
################################################################################
#   Purpose:                                                                   #
#       Calculates roots of a function using Steffensen's method.              #
################################################################################
#   Author:     Ryan Maguire                                                   #
#   Date:       May 25, 2025.                                                  #
################################################################################
"""

# Pylint doesn't like "x" as a variable name. Disable this warning.
# pylint: disable = invalid-name

# Computes the root of a function via Steffensen's method.
def steffensen(f, x):
    """
        Function:
            steffensen
        Purpose:
            Computes the root of a function f: R -> R.
        Arguments:
            f (function):
                A function f: R -> R. The root of f is computed.
            x (float):
                The guess point for the root of f.
        Output:
            root (float):
                A root of the function f near x.
    """

    # Steffensen's method is iterative. The convergence is quadratic, meaning
    # the number of accurate decimals doubles with each iteration. Because of
    # this we can halt the algorithm after a few steps.
    maximum_number_of_iterations = 16

    # Maximum allowed error. This is 4x double precision epsilon.
    epsilon = 8.881784197001252E-16

    # Steffensen's method starts the process at the guess point.
    xn = x

    # Iteratively perform Steffensen's method.
    for _ in range(maximum_number_of_iterations):

        # Steffensen's method needs the evaluations f(x) and f(x + f(x)),
        # in particular the denominator is f(x + f(x)) / f(x) - 1.
        f_xn = f(xn)
        g_xn = f(xn + f_xn) / f_xn - 1.0

        # Like Newton's method the new point is obtained by subtracting
        # the ratio. g(x) = f(x + f(x))/f(x) - 1 acts as the derivative
        # of f, but we do not explicitly need to calculate f'(x).
        xn = xn - f_xn / g_xn

        # If f(x) is very small, we are close to a root and can break
        # out of this for loop. Check for this.
        if abs(f_xn) < epsilon:
            break

    # Like Newton's method, and like Heron's method, the convergence is
    # quadratic. After a few iterations we will be very to close a root.
    return xn

# Input function for Steffensen's method.
def func(x):
    """
        Computes f(x) = 2 - x^2. sqrt(2) is a root of this, we can compute
        this value by applying Steffensen's method to this function.
    """
    return 2.0 - x*x

# 2 is close enough to sqrt(2) for Steffensen's method to work.
X = 2.0

# Compute sqrt(2) using Steffensen's method and print the result.
sqrt_2 = steffensen(func, X)
print(f'sqrt(2) = {sqrt_2}')
