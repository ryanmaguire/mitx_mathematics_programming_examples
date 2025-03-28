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

/*  C89 does not provide complex numbers, but we can define them.             */
struct complex_number {
    double real, imag;
};

/*  Print a complex number in standard form, x + y*i.                         */
static void print_complex(const struct complex_number * const z)
{
    /*  We can use printf with the correct format specifiers to do the job.   */
    printf("%.16E + %.16E*i\n", z->real, z->imag);
}

/*  Non-zero complex numbers always have a reciprocal.                        */
static void make_reciprocal(struct complex_number * const z)
{
    /*  The formula for the reciprocal is given by:                           *
     *                                                                        *
     *        1       x - iy                                                  *
     *      ------ = -------                                                  *
     *      x + iy    2    2                                                  *
     *               x  + y                                                   *
     *                                                                        *
     *  The denominator is the square or the norm of z. Compute this.         */
    const double norm_squared = z->real*z->real + z->imag*z->imag;

    /*  It is faster to multiply than it is to divide. Compute the reciprocal *
     *  of the previous expression and store it as a variable.                */
    const double rcpr_norm_squared = 1.0 / norm_squared;

    /*  The reciprocal can be computing by scaling the components of z.       */
    z->real *= rcpr_norm_squared;
    z->imag *= -rcpr_norm_squared;
}

/*  Computes the square of a complex number: w = z*z.                         */
static void square_self(struct complex_number * const z)
{
    /*  Complex multiplication is performed using elementary arithmetic and   *
     *  the simplification i^2 = -1. Given z = x + iy, we have:               *
     *                                                                        *
     *       2                                                                *
     *      z  = (x + iy) * (x + iy)                                          *
     *                                                                        *
     *            2                2 2                                        *
     *         = x  + ixy + iyx + i y                                         *
     *                                                                        *
     *            2    2                                                      *
     *         = x  - y  + 2ixy                                               *
     *                                                                        *
     *  The real part is x^2 - y^2, the imaginary part is 2xy. To avoid       *
     *  overwriting the data, we must first save the real component as a new  *
     *  variable. That is, if we naively do:                                  *
     *                                                                        *
     *      z->real = z->real*z->real - z->imag*z->imag;                      *
     *      z->imag = 2.0 * z->real * z->imag;                                *
     *                                                                        *
     *  Then z->imag will have the wrong value! This is because we changed    *
     *  z->real first, and then used the incorrect real part for the          *
     *  computation of the imaginary part. Save z->real as a new variable to  *
     *  prevent this.                                                         */
    const double z_real = z->real;

    /*  We can now safely update our complex number to its square.            */
    z->real = z->real*z->real - z->imag*z->imag;
    z->imag *= 2.0 * z_real;
}

/*  Computes the product of two complex numbers, storing the result in the    *
 *  first variable. This acts as the *= operator for real numbers.            */
static void
multiply_by(struct complex_number * const z,
            const struct complex_number * const w)
{
    /*  Similar to the square_self function, save the real part of z as a new *
     *  variable to avoid overwriting and messing up the computation.         */
    const double z_real = z->real;

    /*  To multiply, use (a + ib)*(c + id) = (ac - bd) + i(ad + bc).          */
    z->real = z->real * w->real - z->imag * w->imag;
    z->imag = z_real * w->imag + z->imag * w->real;
}

/*  Computes powers of a given complex number by repeatedly squaring.         */
static struct complex_number
exp_by_squaring(const struct complex_number * const z, int n)
{
    /*  We start off with out = z, and then apply out = out^2 repeatedly.     */
    struct complex_number output = *z;

    /*  The scale factor is used to handle odd powers. That is, if we have    *
     *  z^(2n+1), we can write this as z^(2n) * z = (z^2)^n * z. The scale    *
     *  factor will pick up the solo "z" term, and the squaring part handles  *
     *  (z^2)^n. Create a variable for this and initialize it to 1.           */
    struct complex_number scale = {1.0, 0.0};

    /*  Special case. If n = 0, then z^0 = 1, by definition. Return 1.        */
    if (n == 0)
        return scale;

    /*  For negative powers use z^n = (1 / z)^(-n) to reduce n to positive.   */
    if (n < 0)
    {
        make_reciprocal(&output);
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
            multiply_by(&scale, &output);
            --n;
        }

        /*  n is now even. Square the output and divide n by two.             */
        square_self(&output);
        n >>= 1;
    }

    /*  n is now 1. The final output is output * scale. Compute this.         */
    multiply_by(&output, &scale);
    return output;
}

/*  Test our routines by computing 1 / (1 + i)^30.                            */
int main(void)
{
    const int power = -30;
    const struct complex_number z = {1.0, 1.0};
    const struct complex_number z_pow = exp_by_squaring(&z, power);
    print_complex(&z_pow);

    return 0;
}
