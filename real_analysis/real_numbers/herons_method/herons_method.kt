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
 *  Date:   2025/05/18                                                        *
 ******************************************************************************/
import kotlin.math.abs

/******************************************************************************
 *  Function:                                                                 *
 *      heronsMethod                                                          *
 *  Purpose:                                                                  *
 *      Computes square roots of positive real numbers using Heron's method.  *
 *  Arguments:                                                                *
 *      x (Double):                                                           *
 *          A positive real number, the input to the square root function.    *
 *  Output:                                                                   *
 *      sqrt_x (Double):                                                      *
 *          The square root of the input.                                     *
 ******************************************************************************/
fun heronsMethod(x: Double): Double {

    /*  Heron's method is iterative and the convergence is quadratic. This    *
     *  means that if a_{n} has N correct decimals, then a_{n+1} will have    *
     *  2N correct decimals. A standard 64-bit double can fit about 16        *
     *  decimals of precision (the exact value is 2^-52 ~= 2.22x10^-16).      *
     *  Because of this we may exit the function after a few iterations.      */
    val maximumNumberOfIterations: Int = 16

    /*  The maximum allowed error. This is double precision epsilon.          */
    val epsilon: Double = 2.220446049250313E-16

    /*  Set the initial guess to the input. Provided x is positive, Heron's   *
     *  method will indeed converge.                                          */
    var approximateRoot: Double = x

    /*  Iteratively loop through and obtain better approximations for sqrt(x).*/
    for (iters in 0 .. maximumNumberOfIterations) {

        /*  If we are within epsilon of the correct value we may break out of *
         *  this for-loop. Use the absolute value function to check.          */
        val error: Double = (x - approximateRoot * approximateRoot) / x

        if (abs(error) <= epsilon)
            break

        /*  Apply Heron's method to get a better approximation for the root.  */
        approximateRoot = 0.5 * (approximateRoot + x / approximateRoot)
    }

    /*  As long as x is positive and not very large, we should have a very    *
     *  good approximation for sqrt(x). Heron's method will still work for    *
     *  very large x, but we must increase maximum_number_of_iterations.      */
    return approximateRoot
}
/*  End of heronsMethod.                                                      */

/*  Test out our function, compute the square root of 2.                      */
fun main() {
    val x = 2.0
    val sqrt_x = heronsMethod(x)
    println("sqrt($x) = $sqrt_x")
}
