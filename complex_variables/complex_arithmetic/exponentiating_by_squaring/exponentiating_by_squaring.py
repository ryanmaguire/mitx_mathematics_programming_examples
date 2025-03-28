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
#       Computes powers using exponentiation by squaring.                      #
################################################################################
#   Author: Ryan Maguire                                                       #
#   Date:   2025/03/28                                                         #
################################################################################
"""

# Pylint doesn't like "x", "y", or "z" as variable names. Disable this warning.
# pylint: disable = invalid-name

# Computes z^n using exponentiation by squaring.
def exp_by_squaring(z, n):
    """
        Function:
            exp_by_squaring
        Purpose:
            Computes z^n using exponentiation by squaring.
        Arguments:
            z (float, complex):
                Any real or complex number.
            n (int):
                The power z is being raised to.
        Output:
            z_pow (float, complex):
                The nth power of z, z^n.
    """

    # Special case, z^0 = 1 by definition.
    if n == 0:
        return 1

    # Start the squaring process at the input.
    output = z

    # Negative powers are just powers of the reciprocal.
    if n < 0:
        output = 1 / output
        n = -n

    scale = 1.0

    # Loop through and keep squaring.
    while n > 1:

        # Check if n is odd. The % symbol lets us compute n mod 2.
        # Here we must compute x^(2n+1) = x^(2n) * x.
        if n % 2 == 1:
            scale *= output
            n -= 1

        # Compute another square and cut n in half.
        output *= output
        n >>= 1

    return output * scale

# Test our function with a short program.
if __name__ == "__main__":
    z_val = 1.0 + 1.0j
    power = -30
    z_pow = exp_by_squaring(z_val, power)
    print(z_pow)
