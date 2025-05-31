"""
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
#   Date:   2025/03/08                                                         #
################################################################################
"""

# Pylint doesn't like "x" as a variable name. Disable this warning.
# pylint: disable = invalid-name

# Computes the square root of a positive real number via Heron's method.
def herons_method(x):
    """
        Function:
            herons_method
        Purpose:
            Applies Heron's method to a positive real number, returning
            the square root of it.
        Arguments:
            x (float):
                A positive real number.
        Output:
            sqrt_x (float):
                The square root of x.
    """

    # Heron's method only works for strictly positive real numbers.
    if x <= 0.0:
        raise ValueError("Input must be a positive real number.")

    # Heron's method is iterative and the convergence is quadratic. This
    # means that if a_{n} has N correct decimals, then a_{n+1} will have
    # 2N correct decimals. A standard 64-bit double can fit about 16
    # decimals of precision (the exact value is 2^-52 ~= 2.22x10^-16).
    # Because of this we may exit the function after a few iterations.
    maximum_number_of_iterations = 16

    # The maximum allowed error. This is double precision epsilon.
    epsilon = 2.220446049250313E-16

    # Set the initial guess to the input. Provided x is positive, Heron's
    # method will indeed converge.
    approximate_root = x

    # Iteratively loop through and obtain better approximations for sqrt(x).
    for _ in range(maximum_number_of_iterations):

        # If we are within epsilon of the correct value we may break out of
        # this for-loop. Use the absolute value function to check.
        error = (x - approximate_root * approximate_root) / x

        if abs(error) <= epsilon:
            break

        # Apply Heron's method to get a better approximation for the root.
        approximate_root = 0.5 * (approximate_root + x / approximate_root)

    # As long as x is positive and not very large, we should have a very
    # good approximation for sqrt(x). Heron's method will still work for
    # very large x, but we must increase maximum_number_of_iterations.
    return approximate_root

def main():
    """
        Main routine for testing our implementation of Heron's method.
    """
    x = 2.0
    sqrt_x = herons_method(x)
    print(f"sqrt({x}) = {sqrt_x}")

if __name__ == "__main__":
    main()

# We can run this using the standard Python implementation, C-Python:
#   https://www.python.org/downloads/
# Once installed, run:
#   python3 herons_method.py
# Depending on your platform you may need to replace "python3" with "python"
# or "py" or "py3". This will output:
#   sqrt(2.0) = 1.414213562373095
# This has relative error 1.570092458683775E-16.
