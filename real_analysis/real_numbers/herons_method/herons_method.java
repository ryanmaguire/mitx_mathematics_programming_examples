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

/*  Implementation of sqrt using Heron's method.                              */
final public class Heron {

    /*  Heron's method is iterative and the convergence is quadratic. This    *
     *  means that if a_{n} has N correct decimals, then a_{n+1} will have    *
     *  2N correct decimals. A standard 64-bit double can fit about 16        *
     *  decimals of precision (the exact value is 2^-52 ~= 2.22x10^-16).      *
     *  Because of this we may exit the function after a few iterations.      */
    static private final int maximum_number_of_iterations = 16;

    /*  The maximum allowed error. This is double precision epsilon.          */
    static private final double epsilon = 2.220446049250313E-16;

    /*  Function for computing the square root of a positive real number      *
     *  using Heron's method.                                                 */
    static private double heronsMethod(double x)
    {
        /*  Dummy variable for keeping track of the number of iterations.     */
        int iters;

        /*  Starting value for Heron's method. The input will suffice.        */
        double approximate_root = x;

        /*  Loop through and iteratively perform Heron's method.              */
        for (iters = 0; iters < maximum_number_of_iterations; ++iters)
        {
            /*  If the error is small enough we can break out of the loop. We *
             *  want small relative error, so compute this.                   */
            final double error = (x - approximate_root * approximate_root) / x;

            if (Math.abs(error) <= epsilon)
                break;

            /*  Otherwise improve the error by applying Heron's method.       */
            approximate_root = 0.5 * (approximate_root + x / approximate_root);
        }

        /*  As long as x is positive and not very large, we should have a     *
         *  very good approximation for sqrt(x). Heron's method works for     *
         *  large x, but we may need to increase maximum_number_of_iterations.*/
        return approximate_root;
    }

    /*  Main routine for testing our implementation of Heron's method.        */
    static public void main(String[] args)
    {
        /*  Test out Heron's method by computing sqrt(2).                     */
        final double x = 2.0;
        final double sqrt_x = Heron.heronsMethod(x);
        System.out.printf("sqrt(%f) = %.16f\n", x, sqrt_x);
    }
}
