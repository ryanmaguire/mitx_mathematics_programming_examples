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
function heronsMethod(x: number): number {

    /*  Heron's method is iterative and the convergence is quadratic. This    *
     *  means that if a_{n} has N correct decimals, then a_{n+1} will have    *
     *  2N correct decimals. A standard 64-bit double can fit about 16        *
     *  decimals of precision (the exact value is 2^-52 ~= 2.22x10^-16).      *
     *  Because of this we may exit the function after a few iterations.      */
    const MAXIMUM_NUMBER_OF_ITERATIONS: number = 16;

    /*  The maximum allowed error. This is double precision epsilon.          */
    const EPSILON: number = 2.220446049250313E-16;

    /*  Variable for keeping track of how many iterations we have performed.  */
    let iters: number;

    /*  Set the initial guess to the input. Provided x is positive, Heron's   *
     *  method will indeed converge.                                          */
    let approximateRoot: number = x;

    /*  Iteratively loop through and obtain better approximations for sqrt(x).*/
    for (iters = 0; iters < MAXIMUM_NUMBER_OF_ITERATIONS; ++iters) {

        /*  If we are within epsilon of the correct value we may break out of *
         *  this for-loop. Use the absolute value function to check.          */
        const error: number = (x - approximateRoot * approximateRoot) / x;

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
const X: number = 2.0;
const SQRT_2: number = heronsMethod(X);
const output: string = "sqrt(2) = " + SQRT_2.toFixed(16);
console.log(output);

/*  We can run this by installing node.js and tsx:                            *
 *      https://nodejs.org/en                                                 *
 *  Using the node package manager (npm), install tsx by typing:              *
 *      npm install -g tsx                                                    *
 *  Run the file by typing:                                                   *
 *      npx tsx herons_method.ts                                              *
 *  This will output the following:                                           *
 *      sqrt(2.0) = 1.4142135623730949                                        *
 *  This has a relative error of 1.570092458683775E-16.                       */
