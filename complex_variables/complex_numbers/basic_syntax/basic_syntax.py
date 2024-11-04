"""
################################################################################
#                                   LICENSE                                    #
################################################################################
#   This file is part of newtonian_black_holes.                                #
#                                                                              #
#   newtonian_black_holes is free software: you can redistribute it and/or     #
#   modify it under the terms of the GNU General Public License as published   #
#   by the Free Software Foundation, either version 3 of the License, or       #
#   (at your option) any later version.                                        #
#                                                                              #
#   newtonian_black_holes is distributed in the hope that it will be useful,   #
#   but WITHOUT ANY WARRANTY; without even the implied warranty of             #
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the              #
#   GNU General Public License for more details.                               #
#                                                                              #
#   You should have received a copy of the GNU General Public License          #
#   along with newtonian_black_holes.  If not, see                             #
#   <https://www.gnu.org/licenses/>.                                           #
################################################################################
#   Purpose:                                                                   #
#       Provides basic syntax for complex numbers in Python.                   #
################################################################################
#   Author: Ryan Maguire                                                       #
#   Date:   2024/11/04                                                         #
################################################################################
"""

# Pylint doesn't like "x", "y", or "z" as variable names.
# Disable this warning.
# pylint: disable = invalid-name

# Functions for complex numbers provided here.
import cmath

# Create a complex number. Python uses j instead of i. Probably
# because i is often used for indexing arrays and running for-loops.
z = 1.0 + 1.0j

# We can compute the real and imaginary parts with ease.
x = z.real
y = z.imag

# And we can get the polar form too. Calling the principal argument the "phase"
# is a terminology most often found in electrical engineering, astronomy,
# and signal processing.
r = abs(z)
theta = cmath.phase(z)

# Python uses "f-strings" to print things to the screen.
print(f"z = {x} + {y} i")
print(f"|z| = {r}")
print(f"Arg(z) = {theta}")
