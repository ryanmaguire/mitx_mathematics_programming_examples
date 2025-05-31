################################################################################
#                                   LICENSE                                    #
################################################################################
#   This file is part of mitx_mathematics_programming_examples.                #
#                                                                              #
#   mitx_mathematics_programming_examples is free software: you can            #
#   redistribute it and/or modify it under the terms of the GNU General        #
#   Public License as published by the Free Software Foundation, either        #
#   version 3 of the License, or (at your option) any later version.           #
#                                                                              #
#   mitx_mathematics_programming_examples is distributed in the hope that      #
#   it will be useful but WITHOUT ANY WARRANTY; without even the implied       #
#   warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           #
#   See the GNU General Public License for more details.                       #
#                                                                              #
#   You should have received a copy of the GNU General Public License          #
#   along with mitx_mathematics_programming_examples. If not, see              #
#   <https://www.gnu.org/licenses/>.                                           #
################################################################################
#   Purpose:                                                                   #
#       Calculates square roots using Heron's method.                          #
################################################################################
#   Author: Ryan Maguire                                                       #
#   Date:   2025/05/18                                                         #
################################################################################

# Computes the square root of a positive real number via Heron's method.
herons_method <- function(x) {

    # Heron's method is iterative and the convergence is quadratic. This
    # means that if a_{n} has N correct decimals, then a_{n+1} will have
    # 2N correct decimals. A standard 64-bit double can fit about 16
    # decimals of precision (the exact value is 2^-52 ~= 2.22x10^-16).
    # Because of this we may exit the function after a few iterations.
    maximum_number_of_iterations <- 16

    # The maximum allowed error. This is double precision epsilon.
    epsilon = 2.220446049250313E-16

    # Set the initial guess to the input. Provided x is positive, Heron's
    # method will indeed converge.
    approximate_root <- x

    # Iteratively loop through and obtain better approximations for sqrt(x).
    for (iters in 1:maximum_number_of_iterations) {

        # If we are within epsilon of the correct value we may break out of
        # this for-loop. Use the absolute value function to check.
        error <- (x - approximate_root * approximate_root) / x

        if (abs(error) < epsilon) {
            break
        }

        # Apply Heron's method to get a better approximation for the root.
        approximate_root <- 0.5 * (approximate_root + x / approximate_root)
    }

    # As long as x is positive and not very large, we should have a very
    # good approximation for sqrt(x). Heron's method will still work for
    # very large x, but we must increase maximum_number_of_iterations.
    return(approximate_root)
}

# Test out the function, try computing sqrt(2).
x_val <- 2.0
sqrt_2 <- herons_method(x_val)
output <- sprintf("sqrt(%.1f) = %.16f", x_val, sqrt_2)
message(output)

# We can run this by installing R.
#   https://www.r-project.org/
# Once installed, type:
#   Rscript herons_method.r
# This will output:
#   sqrt(2.0) = 1.4142135623730949
# This has relative error 1.570092458683775E-16.
