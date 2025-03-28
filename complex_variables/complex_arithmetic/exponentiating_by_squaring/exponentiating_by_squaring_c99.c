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
 *  Date:   2025/03/28                                                        *
 ******************************************************************************/

/*  stdio.h provides the "printf" function, used for printing text.           */
#include <stdio.h>

/*  Complex numbers provided here (C99 compatible compiler required).         */
#include <complex.h>

/*  Print a complex number in standard form, x + y*i.                         */
static void print_complex(complex double z)
{
    /*  We can use printf with the correct format specifiers to do the job.   */
    printf("%.16E + %.16E*i\n", creal(z), cimag(z));
}

/*  Computes powers of a given complex number by repeatedly squaring.         */
static complex double exp_by_squaring(complex double z, int n)
{
    /*  We start off with out = z, and then apply out = out^2 repeatedly.     */
    complex double output = z;

    /*  The scale factor is used to handle odd powers. That is, if we have    *
     *  z^(2n+1), we can write this as z^(2n) * z = (z^2)^n * z. The scale    *
     *  factor will pick up the solo "z" term, and the squaring part handles  *
     *  (z^2)^n. Create a variable for this and initialize it to 1.           */
    complex double scale = 1.0;

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

/*  Test our routines by computing 1 / (1 + i)^30.                            */
int main(void)
{
    const int power = -30;
    const complex double z = 1.0 + (complex double)I*1.0;
    const complex double z_pow = exp_by_squaring(z, power);
    print_complex(z_pow);

    return 0;
}
