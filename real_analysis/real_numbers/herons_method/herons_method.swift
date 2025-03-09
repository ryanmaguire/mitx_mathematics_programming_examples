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

/*  fabs (floating-point absolute value) found here.                          */
import Foundation

/*  Heron's method is iterative and the convergence is quadratic. This means  *
 *  that if a_{n} has N correct decimals, then a_{n+1} will have 2N correct   *
 *  decimals. A standard 64-bit double can fit about 16 decimals of precision *
 *  (the exact value is 2^-52 ~= 2.22x10^-16). Because of this we may exit    *
 *  the function after a few iterations.                                      */
let maximum_number_of_iterations: UInt32 = 16;

/*  The maximum allowed error. This is double precision epsilon.              */
let epsilon: Double = 2.220446049250313E-16;

/*  Function for computing square roots using Heron's method.                 */
func heronsMethod(x: Double) -> Double {

    /*  Starting value for Heron's method. The input will suffice.            */
    var approximate_root: Double = x;

    /*  Loop through and iteratively perform Heron's method.                  */
    for _ in 0 ..< maximum_number_of_iterations {

        /*  If the error is small enough we can break out of the loop. We     *
         *  want small relative error, so compute this.                       */
        let error: Double = (x - approximate_root * approximate_root) / x;

        if (fabs(error) <= epsilon) {
            break;
        }

        /*  Otherwise improve the error by applying Heron's method.           */
        approximate_root = 0.5 * (approximate_root + x / approximate_root);
    }

    /*  As long as x is positive and not very large, we should have a very    *
     *  good approximation for sqrt(x). Heron's method works for large x, but *
     *  we may need to increasethe value of maximum_number_of_iterations.     */
    return approximate_root;
}

/*  Test out Heron's method by computing sqrt(2).                             */
let x: Double = 2.0;
let sqrt_x: Double = heronsMethod(x: x);
print("sqrt(\(x)) = \(sqrt_x)");
