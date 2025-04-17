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
 *      Calculates the root of a function using bisection.                    *
 ******************************************************************************
 *  Author: Ryan Maguire                                                      *
 *  Date:   2025/04/17                                                        *
 ******************************************************************************/

/*  Function pointer notation is a little confusing. Create a typedef for it  *
 *  so we do not need to explicitly use it later.                             */
type RealFunc = fn(f64) -> f64;

/*  Computes the root of a function using the bisection method.               */
fn bisection_method(f: RealFunc, a: f64, b: f64) -> f64 {

    /*  Tell the algorithm to stop after several iterations to avoid an       *
     *  infinite loop. Double precision numbers have 52 bits in the mantissa, *
     *  mean if |b - a| ~= 1, after 52 iterations of bisection we will get as *
     *  close as we can to the root. To allow for |b - a| to be larger, halt  *
     *  the algorithm after at most 64 steps.                                 */
    const MAXIMUM_NUMBER_OF_ITERATIONS: u32 = 64;

    /*  Getting exact roots is hard using floating-point numbers. Allow a     *
     *  tolerance in our computation. This value is double precision epsilon. */
    const EPSILON: f64 = 2.220446049250313E-16;

    /*  The midpoint for the bisection method. This will update as we iterate.*/
    let mut midpoint: f64;

    /*  We do not require a < b, nor do we require f(a) < f(b). We only need  *
     *  one of these to evaluate to a negative under f and one to evaluate to *
     *  positive. We will call the negative entry left and positive one right.*/
    let mut left: f64;
    let mut right: f64;

    /*  Evaluate f at the two endpoints to determine which is positive and    *
     *  which is negative. We transform [a, b] to [left, right] by doing this.*/
    let a_eval: f64 = f(a);
    let b_eval: f64 = f(b);

    /*  Rare case, f(a) = 0. Return a, no bisection needed.                   */
    if a_eval == 0.0 {
        return a;
    }

    /*  Similarly, if f(b) = 0, then we have already found the root. Return b.*/
    if b_eval == 0.0 {
        return b;
    }

    /*  Compare the two evaluations and set left and right accordingly.       */
    if a_eval < b_eval {

        /*  If both evaluations are negative, or if both are positive, then   *
         *  the bisection method will not work. Return NaN.                   */
        if b_eval < 0.0 || a_eval > 0.0 {
            return (a - a) / (a - a);
        }

        /*  Otherwise, since f(a) < f(b), set left = a and right = b.         */
        left = a;
        right = b;

    /*  In this case the function starts positive and tends to a negative.    */
    } else {
        /*  Same sanity check as before. We need one evaluation to be         *
         *  negative and one to be positive. Abort if both have the same sign.*/
        if a_eval < 0.0 || b_eval > 0.0 {
            return (a - a) / (a - a);
        }

        /*  Since f(a) > f(b), set left = b and right = a.                    */
        left = b;
        right = a;
    }

    /*  Start the bisection method. Compute the midpoint of a and b.          */
    midpoint = 0.5 * (a + b);

    /*  Iteratively divide the range in half to find the root.                */
    for _ in 0 .. MAXIMUM_NUMBER_OF_ITERATIONS - 1 {

        /*  If f(x) is very small, we are close to a root and can break out   *
         *  of this for loop. Check for this.                                 */
        let eval: f64 = f(midpoint);

        if eval.abs() <= EPSILON {
            break;
        }

        /*  Apply bisection to get a better approximation for the root. We    *
         *  have f(left) < 0 < f(right). If f(midpoint) < 0, replace the      *
         *  interval [left, right] with [midpoint, right]. Set left to the    *
         *  midpoint and reset the midpoint to be closer to right.            */
        if eval < 0.0 {
            left = midpoint;
            midpoint = 0.5 * (midpoint + right);

        /*  In the other case, f(midpoint) > 0, we replace right with the     *
         *  midpoint, changing [left, right] into [left, midpoint]. We then   *
         *  set the midpoint to be closer to left.                            */
        } else {
            right = midpoint;
            midpoint = 0.5 * (left + midpoint);
        }
    }

    /*  After n iterations, we are no more than |b - a| / 2^n away from the   *
     *  root of the function. 1 / 2^n goes to zero very quickly, meaning the  *
     *  convergence is very quick.                                            */
    return midpoint;
}
/*  End of bisection_method.                                                  */

/*  Main routine used for testing our implementation of the bisection method. */
fn main() {

    /*  pi is somewhere between 3 and 4, and it is a root to sine.            */
    const A: f64 = 3.0;
    const B: f64 = 4.0;

    /*  Compute pi using bisection. We should get pi = 3.14159..., accurate   *
     *  to about 16 decimals.                                                 */
    let pi: f64 = bisection_method(f64::sin, A, B);
    println!("pi( = {}", pi);
}
