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

/*  std::io provides the "printfn" function, used for printing text.          */
import std::io;

/*  Floating-point absolute value function, abs, provided here.               */
import std::math;

/*  Create an alias for functions of the form f: R -> R.                      */
alias RealFunc = fn double(double);

/*  Computes the root of a function using Steffensen's method.                */
fn double steffensens_method(RealFunc f, double x)
{
    /*  Steffensen's method is iterative and converges very quickly.          *
     *  Because of this we may exit the function after a few iterations.      */
    const uint MAXIMUM_NUMBER_OF_ITERATIONS = 16U;

    /*  The maximum allowed error. This is 4x double precision epsilon.       */
    const double EPSILON = 8.881784197001252E-16;

    /*  Variable for keeping track of how many iterations we have performed.  */
    uint iters;

    /*  The method starts at the provided guess point and updates iteratively.*/
    double xn = x;

    /*  Iteratively apply Steffensen's method to find the root.               */
    for (iters = 0; iters < MAXIMUM_NUMBER_OF_ITERATIONS; ++iters)
    {
        /*  Steffensen's method needs the evaluations f(x) and f(x + f(x)),   *
         *  in particular the denominator is f(x + f(x)) / f(x) - 1. Compute. */
        double f_xn = f(xn);
        double g_xn = f(xn + f_xn) / f_xn - 1.0;

        /*  Like Newton's method, the new point is obtained by subtracting    *
         *  the ratio. g(x) = f(x + f(x)) / f(x) - 1 acts as the derivative   *
         *  of f, but we do not explicitly need to calculate f'(x).           */
        xn = xn - f_xn / g_xn;

        /*  If f(x) is very small, we are close to a root and can break out   *
         *  of this for loop. Check for this.                                 */
        if (math::abs(f_xn) < EPSILON) {
            break;
        }
    }

    /*  Like Newton's method, and like Heron's method, the convergence is     *
     *  quadratic. After a few iterations we will be very to close a root.    */
    return xn;
}
/*  End of steffensens_method.                                                */

/*  sqrt(2) is a root to the function f(x) = 2 - x^2. Provide this.           */
fn double func(double x)
{
    return 2.0 - x*x;
}
/*  End of func.                                                              */

/*  Main routine used for testing our implementation of Steffensen's method.  */
fn void main()
{
    /*  The initial guess point for Steffensen's method.                      */
    const double X = 2.0;

    /*  Calculate the square root and print it to the screen. If we have      *
     *  written things correctly, we should get 1.414..., which is sqrt(2).   */
    double sqrt_x = steffensens_method(&func, X);
    io::printfn("sqrt(%.1f) = %.16f", X, sqrt_x);
}
