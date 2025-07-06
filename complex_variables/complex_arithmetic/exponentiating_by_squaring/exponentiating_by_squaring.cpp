/******************************************************************************
 *                                  LICENSE                                   *
 ******************************************************************************
 *  This file is part of mitx_mathematics_programming_examples.               *
 *                                                                            *
 *  mitx_mathematics_programming_examples is free software: you can           *
 *  redistribute it and/or modify it under the terms of the GNU General       *
 *  Public License as published by the Free Software Foundation, either       *
 *  version 3 of the License, or (at your option) any later version.          *
 *                                                                            *
 *  mitx_mathematics_programming_examples is distributed in the hope that     *
 *  it will be useful but WITHOUT ANY WARRANTY; without even the implied      *
 *  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.          *
 *  See the GNU General Public License for more details.                      *
 *                                                                            *
 *  You should have received a copy of the GNU General Public License         *
 *  along with mitx_mathematics_programming_examples. If not, see             *
 *  <https://www.gnu.org/licenses/>.                                          *
 ******************************************************************************
 *  Purpose:                                                                  *
 *      Computes z^n for integer n using exponentiation by squaring.          *
 ******************************************************************************
 *  Author: Ryan Maguire                                                      *
 *  Date:   2025/07/04                                                        *
 ******************************************************************************/

/*  stdio provides the "printf" function, used for printing text.             */
#include <cstdio>

/*  Complex numbers provided here.                                            */
#include <complex>

/*  Print a complex number in standard form, x + y*i.                         */
static void print_complex(std::complex<double> z)
{
    /*  We can use printf with the correct format specifiers to do the job.   */
    std::printf("%.16E + %.16E*i\n", z.real(), z.imag());
}

/*  Computes powers of a given complex number by repeatedly squaring.         */
static std::complex<double> exp_by_squaring(std::complex<double> z, int n)
{
    /*  We start off with out = z, and then apply out = out^2 repeatedly.     */
    std::complex<double> output = z;

    /*  The scale factor is used to handle odd powers. That is, if we have    *
     *  z^(2n+1), we can write this as z^(2n) * z = (z^2)^n * z. The scale    *
     *  factor will pick up the solo "z" term, and the squaring part handles  *
     *  (z^2)^n. Create a variable for this and initialize it to 1.           */
    std::complex<double> scale = std::complex<double>(1.0, 0.0);

    /*  Special case. If n = 0, then z^0 = 1, by definition. Return 1.        */
    if (n == 0)
        return scale;

    /*  For negative powers use z^n = (1 / z)^(-n) to reduce n to positive.   */
    if (n < 0)
    {
        output = 1.0 / output;
        n = -n;
    }

    /*  Start the process. Compute z^n by removing all of the even factors    *
     *  for n, iteratively updating the output along the way.                 */
    while (n > 1)
    {
        /*  If n is odd, n = 2*k+1, and if w = output, then:                  *
         *                                                                    *
         *       n    2k + 1                                                  *
         *      w  = w                                                        *
         *                                                                    *
         *            -  2 -  n                                               *
         *         = | w    |   * w                                           *
         *            -    -                                                  *
         *                                                                    *
         *  Multiply "scale" by "output" to handle the "* w" on the right     *
         *  side of the expression. We can continue squaring, replacing       *
         *  output with output^2, to handle portion of this expression that   *
         *  is inside of the parentheses.                                     */
        if ((n % 2) == 1)
        {
            scale *= output;
            --n;
        }

        /*  n is now even. Square the output and divide n by two.             */
        output *= output;
        n >>= 1;
    }

    /*  n is now 1. The final output is output * scale. Compute this.         */
    return output * scale;
}

/*  Let's extend the complex<double> class by providing the "^" operator.     */
class Complex : public std::complex<double> {
    public:

        /*  Constructor from real and imaginary parts, z = x + iy.            */
        Complex(double real, double imag) : std::complex<double>(real, imag)
        {
            /*  Nothing to do, simply inherit the std::complex constructor.   */
        }

        /*  Constructor from a complex number, z = w.                         */
        Complex(const std::complex<double>& other) : std::complex<double>(other)
        {
            /*  Similarly, we do not need to add more functionality.          */
        }

        /*  Provide the "^" operator for complex numbers. We can then write   *
         *  something like w = z^n, instead of w = exp_by_squaring(z, n).     */
        Complex operator ^ (int n) const
        {
            return Complex(exp_by_squaring(*this, n));
        }

        /*  Provide the print function as a method for the class.             */
        void print(void) const
        {
            print_complex(*this);
        }
};

/*  Test our routines by computing 1 / (1 + i)^30.                            */
int main(void)
{
    const int n = -30;
    const Complex z = Complex(1.0, 1.0);
    const Complex w = z^n;
    w.print();
    return 0;
}
