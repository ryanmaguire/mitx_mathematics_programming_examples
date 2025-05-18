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

/*  Computes the square root of a positive real number via Heron's method.    */
function heronsMethod(x) {

    /*  Heron's method is iterative and the convergence is quadratic. This    *
     *  means that if a_{n} has N correct decimals, then a_{n+1} will have    *
     *  2N correct decimals. A standard 64-bit double can fit about 16        *
     *  decimals of precision (the exact value is 2^-52 ~= 2.22x10^-16).      *
     *  Because of this we may exit the function after a few iterations.      */
    const MAXIMUM_NUMBER_OF_ITERATIONS = 16;

    /*  The maximum allowed error. This is double precision epsilon.          */
    const EPSILON = 2.220446049250313E-16;

    /*  Variable for keeping track of how many iterations we have performed.  */
    let iters;

    /*  Set the initial guess to the input. Provided x is positive, Heron's   *
     *  method will indeed converge.                                          */
    let approximateRoot = x;

    /*  Iteratively loop through and obtain better approximations for sqrt(x).*/
    for (iters = 0; iters < MAXIMUM_NUMBER_OF_ITERATIONS; ++iters) {

        /*  If we are within epsilon of the correct value we may break out of *
         *  this for-loop. Use the absolute value function to check.          */
        const error = (x - approximateRoot * approximateRoot) / x;

        if (Math.abs(error) <= EPSILON) {
            break;
        }

        /*  Apply Heron's method to get a better approximation for the root.  */
        approximateRoot = 0.5 * (approximateRoot + x / approximateRoot);
    }

    /*  As long as x is positive and not very large, we should have a very    *
     *  good approximation for sqrt(x). Heron's method will still work for    *
     *  very large x, but we must increase MAXIMUM_NUMBER_OF_ITERATIONS.      */
    return approximateRoot;
}
/*  End of heronsMethod.                                                      */

/*  Test out our function, compute sqrt(2) and print it to the screen.        */
const X = 2.0;
const SQRT_2 = heronsMethod(X);
console.log("sqrt(2) = " + SQRT_2.toFixed(16));
