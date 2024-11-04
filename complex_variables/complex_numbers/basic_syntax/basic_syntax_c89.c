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
 *      Provides basic syntax for complex numbers using the C89 standard.     *
 ******************************************************************************
 *  Author: Ryan Maguire                                                      *
 *  Date:   2024/11/04                                                        *
 ******************************************************************************/

/*  As before, stdio.h provides the "printf" function.                        */
#include <stdio.h>

/*  The standard library provides sqrt and atan2. sqrt computes the square    *
 *  root of a non-negative real number, and atan2 computes the angle the      *
 *  point (x, y) in the plane makes with the x axis.                          */
#include <math.h>

/*  Mimicing other programming libraries, let's define a complex number as an *
 *  ordered pair of real numbers.                                             */
typedef struct {
    double real;
    double imag;
} complex;

/*  UNIMPORTANT NOTE.                                                         *
 *      Every function to follow (except main) will have the word "static"    *
 *      before it. This simply means the function is only used in this file.  *
 *      Since this is a small demo, and not a programming library, every      *
 *      function is declared "static." Doing this makes compilers happier.    *
 *      The student can simply ignore this keyword.                           */

/*  This function computes the real part of a complex number. It is           *
 *  equivalent to Re(z) in our notation.                                      */
static double real_part(complex z)
{
    /*  To access the elements in our "struct", we use dot notation.          *
     *  z is a struct with variables "real" and "imag" stored inside.         *
     *  To access the "real" variable, we write z.real.                       *
     *  Return this to compute the real part of z.                            */
    return z.real;
}

/*  Similarly, this function computes Im(z).                                  */
static double imag_part(complex z)
{
    /*  To access imag, write z.imag.                                         */
    return z.imag;
}

/*  This function computes the magnitude of z.                                */
static double modulus(complex z)
{
    /*  Use the Pythagorean formula to compute |z|.                           */
    double real_squared = z.real * z.real;
    double imag_squared = z.imag * z.imag;

    /*  Pythagoras: Square root of the sum of the squares.                    */
    return sqrt(real_squared + imag_squared);
}

/*  Computes the principal argument of z.                                     */
static double principal_argument(complex z)
{
    /*  math.h provides atan2, which computes the angle the point (x, y)      *
     *  makes with the positive x axis. This is the unique number theta, with *
     *  -pi < theta <= pi, that contains (x, y) on the ray of angle theta. By *
     *  convention, atan2(0, 0) = 0.                                          *
     *                                                                        *
     *  NOTE:                                                                 *
     *      The syntax is theta = atan2(y, x). DO NOT WRITE atan2(x, y).      */
    return atan2(z.imag, z.real);
}

/*  Same routine as before, printing out some values using our new functions. */
int main(void)
{
    /*  Lacking a compiler that implements complex numbers directly, we       *
     *  create complex numbers using "struct" syntax. This looks as follows.  */
    complex z = {1.0, 1.0}; /* This is z = 1 + i. */

    /*  Get the real and imaginary parts of z.                                */
    double x = real_part(z);
    double y = imag_part(z);

    /*  And get the polar form of z.                                          */
    double r = modulus(z);
    double theta = principal_argument(z);

    /*  Print everything to the screen, just as before.                       */
    printf("z = %f + %f i\n", x, y);
    printf("|z| = |%f + %f i| = %f\n", x, y, r);
    printf("Arg(z) = Arg(%f + %f i) = %f\n", x, y, theta);
    return 0;
}
