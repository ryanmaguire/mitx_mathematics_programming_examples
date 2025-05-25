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

# Computes the root of a function using Steffensen's method.
steffensen <- function(f, x) {

    # Steffensen's method is iterative and converges very quickly.
    # Because of this we may exit the function after a few iterations.
    maximum_number_of_iterations <- 64

    # The maximum allowed error. This is 4x double precision epsilon.
    epsilon <- 8.881784197001252E-16

    # The method starts at the provided guess point and updates iteratively.
    xn <- x

    # Iteratively apply Steffensen's method to find the root.
    for (iters in 1:maximum_number_of_iterations) {

        # Steffensen's method needs the evaluations f(x) and f(x + f(x)),
        # in particular the denominator is f(x + f(x)) / f(x) - 1. Compute.
        f_xn <- f(xn)
        g_xn <- f(xn + f_xn) / f_xn - 1.0

        # Like Newton's method, the new point is obtained by subtracting
        # the ratio. g(x) = f(x + f(x)) / f(x) - 1 acts as the derivative
        # of f, but we do not explicitly need to calculate f'(x).
        xn <- xn - f_xn / g_xn

        # If f(x) is very small, we are close to a root and can break out
        # of this for loop. Check for this.
        if (abs(f_xn) < epsilon) {
            break
        }
    }

    # Like Newton's method, and like Heron's method, the convergence is
    # quadratic. After a few iterations we will be very to close a root.
    return(xn)
}
# End of steffensen.

# sqrt(2) is a root to the function f(x) = 2 - x^2.
f <- function(x) {
    return(2.0 - x*x)
}

# The initial guess point for Steffensen's method.
x <- 2.0

# Calculate the square root and print it to the screen. If we have
# written things correctly, we should get 1.414..., which is sqrt(2).
sqrt_x <- steffensen(f, x)
output = sprintf("sqrt(2) = %.16f", sqrt_x)
message(output)
