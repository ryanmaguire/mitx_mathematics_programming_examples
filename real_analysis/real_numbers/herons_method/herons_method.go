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
package main

/*  Only standard library imports are needed.                                 */
import (
    "fmt"   /*  Printf provided here, used for printing text to the screen.   */
    "math"  /*  Abs, floating-point absolute value function, found here.      */
)

/*  Computes the square root of a positive real number via Heron's method.    */
func herons_method(x float64) float64 {

    /*  Heron's method is iterative and the convergence is quadratic. This    *
     *  means that if a_{n} has N correct decimals, then a_{n+1} will have    *
     *  2N correct decimals. A standard 64-bit double can fit about 16        *
     *  decimals of precision (the exact value is 2^-52 ~= 2.22x10^-16).      *
     *  Because of this we may exit the function after a few iterations.      */
    const maximum_number_of_iterations uint32 = 16

    /*  The maximum allowed error. This is 4x double precision epsilon.       */
    const epsilon float64 = 8.881784197001252E-16

    /*  Variable for keeping track of how many iterations we have performed.  */
    var iters uint32

    /*  Set the initial guess to the input. Provided x is positive, Heron's   *
     *  method will indeed converge.                                          */
    var approximate_root = x

    /*  Iteratively loop through and obtain better approximations for sqrt(x).*/
    for iters = 0; iters < maximum_number_of_iterations; iters += 1 {

        /*  If we are within epsilon of the correct value we may break out of *
         *  this for-loop. Use the absolute value function to check.          */
        var error = (x - approximate_root * approximate_root) / x

        if math.Abs(error) <= epsilon {
            break
        }

        /*  Apply Heron's method to get a better approximation for the root.  */
        approximate_root = 0.5 * (approximate_root + x / approximate_root)
    }

    /*  As long as x is positive and not very large, we should have a very    *
     *  good approximation for sqrt(x). Heron's method will still work for    *
     *  very large x, but we must increase maximum_number_of_iterations.      */
    return approximate_root
}
/*  End of herons_method.                                                     */

/*  Main routine used for testing our implementation of Heron's method.       */
func main() {

    /*  The input to Heron's method, the value we want to compute the square  *
     *  root of.                                                              */
    const x float64 = 2.0

    /*  Calculate the square root and print it to the screen. If we have      *
     *  written things correctly, we should get 1.414..., which is sqrt(2).   */
    var sqrt_x = herons_method(x)
    fmt.Printf("sqrt(%.1f) = %.16f\n", x, sqrt_x)
}

/*  We can run this on GNU, Linux, FreeBSD, etc., using the GNU Go compiler,  *
 *  which is part of the GNU Compiler Collection (GCC), via:                  *
 *      gccgo herons_method.go -o main                                        *
 *      ./main                                                                *
 *  This will output the following:                                           *
 *      sqrt(2.0) = 1.4142135623730949                                        *
 *  This has a relative error of 1.570092458683775E-16.                       *
 *                                                                            *
 *  On macOS and Windows you can install Google's official Go compiler:       *
 *      https://go.dev/                                                       *
 *  Once installed you can compile and run by typing:                         *
 *      go run herons_method.go                                               *
 *  This will produce the same output.                                        */
