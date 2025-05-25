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
 *      Calculates the root of a function using Steffensen's method.          *
 ******************************************************************************
 *  Author: Ryan Maguire                                                      *
 *  Date:   2025/05/25                                                        *
 ******************************************************************************/

/*  NSObject, base class for all Objective-C classes, found here. math.h and  *
 *  stdio.h are also included in this header file.                            */
#import <Foundation/Foundation.h>

/*  Function pointer notation is a little confusing. Create a typedef for it  *
 *  so we do not need to explicitly use it later.                             */
typedef double (*function)(double);

/*  Class providing an implementation of Steffensen's method.                 */
@interface Steffensen: NSObject
    {
        /*  How many iterations of Steffensen's method we do before exiting.  */
        const unsigned int maximumNumberOfIterations;

        /*  Allowed tolerance for the root-finding method.                    */
        const double epsilon;
    }

    /*  Given a function f: R -> R and a guess point x, this finds a root of  *
     *  f that is near the guess point.                                       */
    + (double) root: (function)f withInitialGuess: (double)x;
@end

@implementation Steffensen

    /*  Steffensen's method is iterative and converges very quickly.          *
     *  Because of this we may exit the function after a few iterations.      */
    static const unsigned int maximum_number_of_iterations = 16U;

    /*  The maximum allowed error. This is 4x double precision epsilon.       */
    static const double epsilon = 8.881784197001252E-16;

    /*  Computes the root of a function using Steffensen's method.            */
    + (double) root: (function) f withInitialGuess: (double) x
    {
        /*  Variable for keeping track of how many iterations we perform.     */
        unsigned int iters;

        /*  The method starts at the guess point and updates iteratively.     */
        double xn = x;

        /*  Iteratively apply Steffensen's method to find the root.           */
        for (iters = 0; iters < maximum_number_of_iterations; ++iters)
        {
            /*  Steffensen's method needs the evaluations f(x) and f(x+f(x)), *
             *  in particular the denominator is f(x + f(x)) / f(x) - 1.      */
            const double f_xn = f(xn);
            const double g_xn = f(xn + f_xn) / f_xn - 1.0;

            /*  Like Newton's method the new point is obtained by subtracting *
             *  the ratio. g(x) = f(x + f(x))/f(x) - 1 acts as the derivative *
             *  of f, but we do not explicitly need to calculate f'(x).       */
            xn = xn - f_xn / g_xn;

            /*  If f(x) is very small, we are close to a root and can break   *
             *  out of this for loop. Check for this.                         */
            if (fabs(f_xn) < epsilon)
                break;
        }

        /*  Like Newton's method, and like Heron's method, the convergence is *
         *  quadratic. After a few iterations we will be very to close a root.*/
        return xn;
    }
    /*  End of root.                                                          */
@end
/*  End of Steffensen implementation.                                         */

/*  sqrt(2) is a root to the function f(x) = 2 - x^2. Provide this.           */
static double func(double x)
{
    return 2.0 - x*x;
}
/*  End of func.                                                              */

/*  Main routine used for testing our implementation of Steffensen's method.  */
int main(void)
{
    /*  The initial guess point for Steffensen's method.                      */
    const double x = 2.0;

    /*  Calculate the square root and print it to the screen. If we have      *
     *  written things correctly, we should get 1.414..., which is sqrt(2).   */
    const double sqrt_x = [Steffensen root: func withInitialGuess: x];
    printf("sqrt(%.1f) = %.16f\n", x, sqrt_x);

    return 0;
}
