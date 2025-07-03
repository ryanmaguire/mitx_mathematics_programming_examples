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

/*  NSObject, which is the base class for all Objective-C classes, found here.*/
#import <Foundation/Foundation.h>

/*  The original Objective-C was a superset of the old C standard, which does *
 *  not provide complex numbers. We can define them using a class.            */
@interface Complex: NSObject
    {
        double real, imag;
    }

    - (id) init: (double)re imagPart: (double)im;
    - (void) print;
    - (void) makeReciprocal;
    - (void) squareSelf;
    - (void) multiplyBy: (const Complex * const)other;
    - (id) pow: (int)n;
@end

@implementation Complex

    /*  Create a complex number from real ones, the real and imaginary parts. */
    - (id) init: (double)re imagPart: (double)im
    {
        self = [super init];

        /*  Ensure that the object is not nil.                                */
        if (!self)
            return self;

        /*  Otherwise, create the number z = re + im*i.                       */
        real = re;
        imag = im;

        return self;
    }

    /*  Print a complex number in standard form, x + y*i.                     */
    - (void) print
    {
        /*  Use printf with the correct format specifiers to print things.    */
        printf("%.16E + %.16E*i\n", real, imag);
    }

    /*  Non-zero complex numbers always have a reciprocal.                    */
    - (void) makeReciprocal
    {
        /*  The formula for the reciprocal is given by:                       *
         *                                                                    *
         *        1       x - iy                                              *
         *      ------ = -------                                              *
         *      x + iy    2    2                                              *
         *               x  + y                                               *
         *                                                                    *
         *  The denominator is the square or the norm of z. Compute this.     */
        const double norm_squared = real*real + imag*imag;

        /*  It is faster to multiply than it is to divide. Compute the        *
         *  reciprocal of the previous expression and store it as a variable. */
        const double rcpr_norm_squared = 1.0 / norm_squared;

        /*  The reciprocal can be computing by scaling the components of z.   */
        real *= rcpr_norm_squared;
        imag *= -rcpr_norm_squared;
    }

    /*  Computes the square of a complex number: w = z*z.                     */
    - (void) squareSelf
    {
        /*  Complex multiplication is performed using elementary arithmetic   *
         *  and the simplification i^2 = -1. Given z = x + iy, we have:       *
         *                                                                    *
         *       2                                                            *
         *      z  = (x + iy) * (x + iy)                                      *
         *                                                                    *
         *            2                2 2                                    *
         *         = x  + ixy + iyx + i y                                     *
         *                                                                    *
         *            2    2                                                  *
         *         = x  - y  + 2ixy                                           *
         *                                                                    *
         *  The real part is x^2 - y^2, the imaginary part is 2xy. To avoid   *
         *  overwriting the data, we must first save the real component as a  *
         *  new variable. That is, if we naively do:                          *
         *                                                                    *
         *      real = real * real - imag * imag;                             *
         *      imag = 2.0 * real * imag;                                     *
         *                                                                    *
         *  Then imag will have the wrong value! This is because we changed   *
         *  real first, and then used the incorrect real part for the         *
         *  computation of the imaginary part. Save real to prevent this.     */
        const double z_real = real;

        /*  We can now safely update our complex number to its square.        */
        real = real*real - imag*imag;
        imag *= 2.0 * z_real;
    }

    /*  Computes the product of two complex numbers, storing the result in    *
     *  the first variable. This acts as the *= operator for real numbers.    */
    - (void) multiplyBy: (const Complex * const) other
    {
        /*  Similar to squareSelf, save the real parts of z and w as new      *
         *  variables to avoid overwriting and ruining the computation.       */
        const double z_real = real;
        const double w_real = other->real;

        /*  To multiply, use (a + ib)*(c + id) = (ac - bd) + i(ad + bc).      */
        real = z_real * w_real - imag * other->imag;
        imag = z_real * other->imag + imag * w_real;
    }

    /*  Computes powers of a given complex number by repeatedly squaring.     */
    - (id) pow: (int) n
    {
        /*  We start off with out = z, and then apply out = out^2 repeatedly. */
        Complex *output = [[Complex alloc] init: real imagPart: imag];

        /*  The scale factor is used to handle odd powers. That is, if we     *
         *  have z^(2n+1), we can write this as z^(2n) * z = (z^2)^n * z. The *
         *  scale factor will pick up the solo "z" term, and the squaring     *
         *  part handles the (z^2)^n term. Create a variable for this and     *
         *  initialize it to 1.                                               */
        Complex *scale = [[Complex alloc] init: 1.0 imagPart: 0.0];

        /*  Special case. If n = 0, then z^0 = 1, by definition. Return 1.    */
        if (n == 0)
        {
            [output release];
            return scale;
        }

        /*  For negative powers use z^n = (1/z)^(-n) to reduce n to positive. */
        if (n < 0)
        {
            [output makeReciprocal];
            n = -n;
        }

        /*  Start the process. Compute z^n by removing all of the even        *
         *  factors for n, iteratively updating the output along the way.     */
        while (n > 1)
        {
            /*  If n is odd, n = 2*k+1, and if w = output, then:              *
             *                                                                *
             *       n    2k + 1                                              *
             *      w  = w                                                    *
             *                                                                *
             *            -  2 -  n                                           *
             *         = | w    |   * w                                       *
             *            -    -                                              *
             *                                                                *
             *  Multiply "scale" by "output" to handle the "* w" on the right *
             *  side of the expression. We can continue squaring, replacing   *
             *  output with output^2, to handle portion of this expression    *
             *  that is inside of the parentheses.                            */
            if ((n % 2) == 1)
            {
                [scale multiplyBy: output];
                --n;
            }

            /*  n is now even. Square the output and divide n by two.         */
            [output squareSelf];
            n >>= 1;
        }

        /*  n is now 1. The final output is output * scale. Compute this.     */
        [output multiplyBy: scale];

        /*  We are done with the scale factor. Release the memory for it.     */
        [scale release];
        return output;
    }
@end

/*  Test our routines by computing 1 / (1 + i)^30.                            */
int main(void)
{
    /*  Autorelease pool for memory management.                               */
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    /*  Compute (1 + i)^-30 using our new Objective-C class.                  */
    const int power = -30;
    Complex * const z = [[Complex alloc] init: 1.0 imagPart: 1.0];
    Complex * const zPow = [z pow: power];

    /*  Print the result to the screen. It should be an imaginary number.     */
    [zPow print];

    /*  Release all of the memory we've used.                                 */
    [z release];
    [zPow release];

    /*  We're done with the computation, drain the autorelease pool.          */
    [pool drain];
    return 0;
}
