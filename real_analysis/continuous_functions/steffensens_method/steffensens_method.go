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
 *  Date:   2025/05/22                                                        *
 ******************************************************************************/
package main

/*  Only standard library imports are needed.                                 */
import (
    "fmt"   /*  Printf provided here, used for printing text to the screen.   */
    "math"  /*  Abs, floating-point absolute value function, found here.      */
)

/*  Type for a function of the form f: R -> R.                                */
type realfunc func(x float64) float64

/*  Computes the root of a function using Steffensen's method.                */
func steffensens_method(f realfunc, x float64) float64 {

    /*  Steffensen's method is iterative and converges very quickly.          *
     *  Because of this we may exit the function after a few iterations.      */
    const maximum_number_of_iterations uint32 = 16

    /*  The maximum allowed error. This is 4x double precision epsilon.       */
    const epsilon float64 = 8.881784197001252e-16

    /*  Variable for keeping track of how many iterations we have performed.  */
    var iters uint32

    /*  The method starts at the provided guess point and updates iteratively.*/
    var xn float64 = x

    /*  Iteratively apply Steffensen's method to find the root.               */
    for iters = 0; iters < maximum_number_of_iterations; iters += 1 {

        /*  Steffensen's method needs the evaluations f(x) and f(x + f(x)),   *
         *  in particular the denominator is f(x + f(x)) / f(x) - 1. Compute. */
        var f_xn float64 = f(xn)
        var g_xn float64 = f(xn + f_xn) / f_xn - 1.0

        /*  Like Newton's method, the new point is obtained by subtracting    *
         *  the ratio. g(x) = f(x + f(x)) / f(x) - 1 acts as the derivative   *
         *  of f, but we do not explicitly need to calculate f'(x).           */
        xn = xn - f_xn / g_xn

        /*  If f(x) is very small, we are close to a root and can break out   *
         *  of this for loop. Check for this.                                 */
        if math.Abs(f_xn) < epsilon {
            break
        }
    }

    /*  Like Newton's method, and like Heron's method, the convergence is     *
     *  quadratic. After a few iterations we will be very to close a root.    */
    return xn
}
/*  End of steffensens_method.                                                */

/*  sqrt(2) is a root to the function f(x) = 2 - x^2. Provide this.           */
func f(x float64) float64 {
    return 2.0 - x*x
}
/*  End of func.                                                              */

/*  Main routine used for testing our implementation of Steffensen's method.  */
func main() {

    /*  The initial guess point for Steffensen's method.                      */
    const x float64 = 2.0

    /*  Calculate the square root and print it to the screen. If we have      *
     *  written things correctly, we should get 1.414..., which is sqrt(2).   */
    var sqrt_x float64 = steffensens_method(f, x)
    fmt.Printf("sqrt(%.1f) = %.16f\n", x, sqrt_x)
}
