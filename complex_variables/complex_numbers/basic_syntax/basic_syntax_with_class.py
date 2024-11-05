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
#       Implements complex numbers using a Python class.                       #
################################################################################
#   Author: Ryan Maguire                                                       #
#   Date:   2024/11/05                                                         #
################################################################################
"""

# The modulus and principal argument of a complex number are computed using
# the square root function and the arctan function. These are found here.
import math

class Complex:
    """
        Class:
            Complex
        Purpose:
            Python class for working with complex numbers.
            This contains methods (functions) for working with
            common routines found in complex analysis, and
            implements the basics of complex arithmetic.
        Attributes:
            real (float):
                The real part of the complex number.
            imag (float):
                The imaginary part of the complex number.
        Operators:
            + (complex addition)
            += (in-place complex addition)
            - (complex subtraction)
            -= (in-place complex subtraction)
            * (complex multiplication)
            *= (in-place complex multiplication)
            / (complex division)
            /= (in-place complex division)
            - (unary operator, complex negation)
    """
    def __init__(self, real, imag):
        """
            Function:
                __init__
            Purpose:
                Creates an instance of the Complex class.
            Arguments:
                real (float):
                    The real part of the complex number.
                imag (float):
                    The imaginary part of the complex number.
            Output:
                z (Complex):
                    The complex number real + i*imag
        """

        # Both inputs should be "floats", which are real numbers in a computer.
        try:
            self.real = float(real)
            self.imag = float(imag)

        # If we can't convert the inputs into floats, the user gave invalid
        # inputs. Treat this as an error.
        except (TypeError, ValueError) as err:
            raise TypeError(
                "A complex number is created from two real numbers."
            ) from err

    # + operator for complex addition.
    def __add__(self, other):
        """
            Operator:
                Addition (+).
            Purpose:
                Performs complex addition.
            Arguments:
                other (Complex):
                    The complex number being added to self.
            Outputs:
                sum (Complex):
                    The complex sum of self and other.
            Method:
                Add the complex numbers component-wise. If self and other
                are represented as z = a + ib and w = c + id,
                respectively, the sum is then:

                    z + w = (a + ib) + (c + id)
                          = (a + c) + i(b + d)

                That is, complex addition is done component-wise.
        """

        # We can only add complex numbers and real numbers together. Check if
        # the input is either of these.
        if not isinstance(other, Complex):

            # The input is not a complex number. See if it is a real number.
            try:
                other_real = float(other)
            except (TypeError, ValueError) as err:
                raise TypeError(
                    "Input is not real or complex. Cannot add."
                ) from err

            # If we get here, the input was a real number. We can add.
            real_sum = self.real + other_real
            imag_sum = self.imag
            return Complex(real_sum, imag_sum)

        # If we get here, the input is a complex number. Add the components.
        real_sum = self.real + other.real
        imag_sum = self.imag + other.imag
        return Complex(real_sum, imag_sum)

    # += operator for complex addition.
    def __iadd__(self, other):
        """
            Operator:
                Addition (+=).
            Purpose:
                Performs complex addition in-place.
            Arguments:
                other (Complex):
                    The complex number being added to self.
            Outputs:
                self
            Method:
                Perform complex addition component-wise and store
                the result in self.
        """

        # Similar error check to the one found in __add__.
        if not isinstance(other, Complex):

            # The input is not a complex number. See if it is a real number.
            try:
                self.real += float(other)
            except (TypeError, ValueError) as err:
                raise TypeError(
                    "Input is not real or complex. Cannot add."
                ) from err

        # If we get here, the input is a complex number. Add the components.
        else:
            self.real += other.real
            self.imag += other.imag

        return self

    # - operator for complex subtraction.
    def __sub__(self, other):
        """
            Operator:
                Subtraction (-).
            Purpose:
                Performs complex subtraction.
            Arguments:
                other (Complex):
                    The complex number being subtracted from self.
            Outputs:
                diff (Complex):
                    The complex difference of self and other.
            Method:
                Subtract the complex numbers component-wise. If self
                and other are represented as z = a + ib and w = c + id,
                respectively, the difference is then:

                    z - w = (a + ib) - (c + id)
                          = (a - c) + i(b - d)

                That is, complex subtraction is done component-wise.
        """

        # We can only subtract complex numbers and real numbers. Check if
        # the input is either of these.
        if not isinstance(other, Complex):

            # The input is not a complex number. See if it is a real number.
            try:
                other_real = float(other)
            except (TypeError, ValueError) as err:
                raise TypeError(
                    "Input is not real or complex. Cannot subtract."
                ) from err

            # If we get here, the input was a real number. We can subtract.
            real_diff = self.real - other_real
            imag_diff = self.imag
            return Complex(real_diff, imag_diff)

        # If we get here, the input is a complex number. Subtract components.
        real_diff = self.real - other.real
        imag_diff = self.imag - other.imag
        return Complex(real_diff, imag_diff)

    # -= operator for complex subtraction.
    def __isub__(self, other):
        """
            Operator:
                Subtraction (-=).
            Purpose:
                Performs complex subtraction in-place.
            Arguments:
                other (Complex):
                    The complex number being subtracted from self.
            Outputs:
                self
            Method:
                Perform complex subtraction component-wise and store
                the result in self.
        """

        # Subtraction can be done with real or complex numbers.
        if not isinstance(other, Complex):

            # The input is not a complex number. See if it is a real number.
            try:
                self.real -= float(other)
            except (TypeError, ValueError) as err:
                raise TypeError(
                    "Input is not real or complex. Cannot subtract."
                ) from err

        # If we get here, the input is a complex number. Subtract components.
        else:
            self.real -= other.real
            self.imag -= other.imag

        return self

    # * operator for complex multiplication.
    def __mul__(self, other):
        """
            Operator:
                Multiplication (*).
            Purpose:
                Performs complex multiplication.
            Arguments:
                other (Complex):
                    A complex number.
            Outputs:
                prod (Complex):
                    The product of self and other.
            Method:
                Complex multiplication is computed using i^2 = -1.
                That is, if z = a + ib, and w = c + id, then:

                    z*w = (a + ib) * (c + id)
                        = ac + ibc + iad + i^2bd
                        = (ac - bd) + i(ad + bc)

                If other is purely real, this is just scalar multiplication.
        """

        # The input must be a real or complex number.
        if not isinstance(other, Complex):
            try:
                other_real = float(other)
            except (TypeError, ValueError) as err:
                raise TypeError(
                    "Input is not real or complex. Cannot multiply."
                ) from err

            # If we get here the input was a real number. Multiply components.
            prod_real = self.real * other_real
            prod_imag = self.imag * other_real
            return Complex(prod_real, prod_imag)

        # If we get here, the input was complex.
        prod_real = self.real * other.real - self.imag * other.imag
        prod_imag = self.real * other.imag + self.imag * other.real
        return Complex(prod_real, prod_imag)

    # * operator for complex multiplication on the right.
    def __rmul__(self, other):
        """
            Operator:
                Multiplication (*).
            Purpose:
                Performs complex multiplication (on the right).
            Arguments:
                other (Complex):
                    A complex number.
            Outputs:
                prod (Complex):
                    The product of self and other.
            Method:
                Complex multiplication is commutative, so this operator
                does the same thing as multiplication on the left.
        """

        # The input must be a real or complex number.
        if not isinstance(other, Complex):
            try:
                other_real = float(other)
            except (TypeError, ValueError) as err:
                raise TypeError(
                    "Input is not real or complex. Cannot multiply."
                ) from err

            # If we get here the input was a real number. Multiply components.
            prod_real = other_real * self.real
            prod_imag = other_real * self.imag
            return Complex(prod_real, prod_imag)

        # If we get here, the input was complex.
        prod_real = other.real * self.real - other.imag * self.imag
        prod_imag = other.real * self.imag + other.imag * self.real
        return Complex(prod_real, prod_imag)

    # *= operator for complex multiplication.
    def __imul__(self, other):
        """
            Operator:
                Multiplication (*=).
            Purpose:
                Performs complex multiplication in-place.
            Arguments:
                other (Complex):
                    A complex number.
            Outputs:
                self.
            Method:
                Performing complex multiplication naively in-place will
                overwrite the real part first, meaning the imaginary part
                will get the wrong input. We correct this by saving the
                real part as a new variable, and performing complex
                multiplication with this.
        """

        # The input must be a real or complex number.
        if not isinstance(other, Complex):
            try:
                other_real = float(other)
            except (TypeError, ValueError) as err:
                raise TypeError(
                    "Input is not real or complex. Cannot multiply."
                ) from err

            # If we get here the input was a real number. Multiply components.
            self.real *= other_real
            self.imag *= other_real
            return self

        # If we get here, the input was complex. Avoid overwriting data,
        # save the real part of self before computing.
        self_real = self.real

        # We can now perform the product.
        self.real = self.real * other.real - self.imag * other.imag
        self.imag = self_real * other.imag + self.imag * other.real
        return self

    # Negation operator.
    def __neg__(self):
        """
            Operator:
                Negation (-):
            Purpose:
                Negates a complex number.
            Arguments:
                None.
            Outputs:
                neg_self (Complex):
                    The negation of self.
            Method:
                Negate each component and return.
        """

        # Negate all components and return.
        real_val = -self.real
        imag_val = -self.imag
        return Complex(real_val, imag_val)

    # Complex conjugation.
    def conj(self):
        """
            Function:
                conj
            Purpose:
                Computes the complex conjugate of a complex number.
            Arguments:
                None.
            Output:
                conj_self (Complex):
                    The complex conjugate of self.
            Method:
                Negate the imaginary part and return.
        """
        return Complex(self.real, -self.imag)

    # Computes the complex modulus, or magnitude, of a complex number.
    def modulus(self):
        """
            Function:
                modulus
            Purpose:
                Computes the complex modulus of a complex number.
            Arguments:
                None.
            Output:
                abs_z (Complex):
                    The magnitude of self.
            Method:
                Use the Pythagorean formula.
        """

        # Pythagorean formula: Square root of the sum of the squares.
        real_squared = self.real * self.real
        imag_squared = self.imag * self.imag
        return math.sqrt(real_squared + imag_squared)

    # Computes the principal argument of a complex number.
    def arg(self):
        """
            Function:
                arg
            Purpose:
                Computes the principal argument of a complex number.
            Arguments:
                None.
            Output:
                arg_z (Complex):
                    The principal argument of self.
            Method:
                Use the atan2 function from the math module.
        """
        return math.atan2(self.imag, self.real)

    # Used for copying an instance of a complex number into a new variable.
    def copy(self):
        """
            Function:
                copy
            Purpose:
                Copies the data of self to a new variable.
            Arguments:
                None.
            Output:
                self_copy (Complex):
                    A copy of self.
        """
        return Complex(self.real, self.imag)

    # Converts a complex number into a string.
    def __str__(self):
        """
            Function:
                __str__
            Purpose:
                Converts a complex number into a string. Used for printing.
            Arguments:
                None.
            Output:
                self_string (str):
                    String representation of self.
        """

        # If the imaginary part is negative, write real - |imag| i, instead
        # of writing real + -imag i.
        if self.imag < 0.0:
            return f'{self.real} - {abs(self.imag)} i'

        return f'{self.real} + {self.imag} i'

# Let's test our routines.
if __name__ == "__main__":

    # Two test complex numbers to play with.
    z = Complex(1.0, 2.0)
    w = Complex(1.0, -1.0)

    # Test out negation.
    neg_z = -z

    # Test out complex arithmetic.
    summ = z + w
    diff = z - w
    prod = z * w

    # And try scalar multiplication.
    right_scale = z * 4.0
    left_scale = 4.0 * z

    # Test basic complex functions.
    magnitude = z.modulus()
    argument = z.arg()

    # Lastly, try out in-place arithmetic.
    new_sum = z.copy()
    new_diff = z.copy()
    new_prod = z.copy()

    new_sum += w
    new_diff -= w
    new_prod *= w

    # Print all of the results to the screen.
    print(f'z = {z}')
    print(f'w = {w}')
    print(f'-z = {neg_z}')
    print(f'z + w = {summ}')
    print(f'z - w = {diff}')
    print(f'z * w = {prod}')
    print(f'4 * z = {left_scale}')
    print(f'z * 4 = {right_scale}')
    print(f'|z| = {magnitude}')
    print(f'Arg(z) = {argument}')
    print(f'z += w -> {new_sum}')
    print(f'z -= w -> {new_diff}')
    print(f'z *= w -> {new_prod}')
