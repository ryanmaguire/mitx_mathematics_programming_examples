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
 *      Calculates square roots using Heron's method.                         *
 ******************************************************************************
 *  Author: Ryan Maguire                                                      *
 *  Date:   2025/03/08                                                        *
 ******************************************************************************/

/*  stdio.h provides the "printf" function, used for printing text.           */
#include <stdio.h>

/*  Floating-point absolute value function, fabs, provided here.              */
#include <math.h>

/*  Computes the square root of a positive real number via Heron's method.    */
static double herons_method(double x)
{
    /*  Heron's method is iterative and the convergence is quadratic. This    *
     *  means that if a_{n} has N correct decimals, then a_{n+1} will have    *
     *  2N correct decimals. A standard 64-bit double can fit about 16        *
     *  decimals of precision (the exact value is 2^-52 ~= 2.22x10^-16).      *
     *  Because of this we may exit the function after a few iterations.      *
     *                                                                        *
     *  Note:                                                                 *
     *      We are declaring the following integer as "unsigned" meaning      *
     *      non-negative. The "U" after the number is the suffix for unsigned *
     *      constants in C. It simply means unsigned.                         */
    const unsigned int maximum_number_of_iterations = 16U;

    /*  The maximum allowed error. This is 4x double precision epsilon.       */
    const double epsilon = 8.881784197001252E-16;

    /*  Variable for keeping track of how many iterations we have performed.  */
    unsigned int iters;

    /*  Set the initial guess to the input. Provided x is positive, Heron's   *
     *  method will indeed converge.                                          */
    double approximate_root = x;

    /*  Iteratively loop through and obtain better approximations for sqrt(x).*/
    for (iters = 0; iters < maximum_number_of_iterations; ++iters)
    {
        /*  If we are within epsilon of the correct value we may break out of *
         *  this for-loop. Use the absolute value function to check.          */
        const double error = (x - approximate_root * approximate_root) / x;

        if (fabs(error) <= epsilon)
            break;

        /*  Apply Heron's method to get a better approximation for the root.  */
        approximate_root = 0.5 * (approximate_root + x / approximate_root);
    }

    /*  As long as x is positive and not very large, we should have a very    *
     *  good approximation for sqrt(x). Heron's method will still work for    *
     *  very large x, but we must increase maximum_number_of_iterations.      */
    return approximate_root;
}
/*  End of herons_method.                                                     */

/*  Main routine used for testing our implementation of Heron's method.       */
int main(void)
{
    /*  The input to Heron's method, the value we want to compute the square  *
     *  root of.                                                              */
    const double x = 2.0;

    /*  Calculate the square root and print it to the screen. If we have      *
     *  written things correctly, we should get 1.414..., which is sqrt(2).   */
    const double sqrt_x = herons_method(x);
    printf("sqrt(%.1f) = %.16f\n", x, sqrt_x);

    return 0;
}

/*  We can execute this on GNU, Linux, FreeBSD, macOS, etc., via:             *
 *      cc herons_method.c -o main                                            *
 *      ./main                                                                *
 *  This will output the following:                                           *
 *      sqrt(2.0) = 1.4142135623730949                                        *
 *  This has a relative error of 1.570092458683775E-16.                       *
 *                                                                            *
 *  On Windows you will need to install a C compiler. Common options are      *
 *  Microsoft's MSVC, LLVM's clang, MinGW (which uses the GNU toolchain),     *
 *  or installing Cygwin and running the commands above. Using MSVC, type:    *
 *      cl herons_method.c /link /out:main.exe                                *
 *      main.exe                                                              *
 *  This will produce the same output.                                        */
