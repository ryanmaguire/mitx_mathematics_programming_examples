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

/*  Class providing an implementation of Steffensen's method.                 */
final public class Steffensen {

    /*  Interface used for defining functions of the type f: R -> R.          */
    interface Function
    {
        double evaluate(double x);
    }

    /*  Steffensen's method is iterative and converges very quickly.          *
     *  Because of this we may exit the function after a few iterations.      */
    static public final int maximumNumberOfIterations = 16;

    /*  The maximum allowed error. This is 4x double precision epsilon.       */
    static public final double epsilon = 8.881784197001252E-16;

    /*  Computes the root of a function using Steffensen's method.            */
    static double root(Function f, double x)
    {
        /*  Variable for keeping track of how many iterations we perform.     */
        int iters;

        /*  The method starts at the guess point and updates iteratively.     */
        double xn = x;

        /*  Iteratively apply Steffensen's method to find the root.           */
        for (iters = 0; iters < maximumNumberOfIterations; ++iters)
        {
            /*  Steffensen's method needs the evaluations f(x) and f(x+f(x)), *
             *  in particular the denominator is f(x + f(x)) / f(x) - 1.      */
            double f_xn = f.evaluate(xn);
            double g_xn = f.evaluate(xn + f_xn) / f_xn - 1.0;

            /*  Like Newton's method the new point is obtained by subtracting *
             *  the ratio. g(x) = f(x + f(x))/f(x) - 1 acts as the derivative *
             *  of f, but we do not explicitly need to calculate f'(x).       */
            xn = xn - f_xn / g_xn;

            /*  If f(x) is very small, we are close to a root and can break   *
             *  out of this for loop. Check for this.                         */
            if (Math.abs(f_xn) < epsilon)
                break;
        }

        /*  Like Newton's method, and like Heron's method, the convergence is *
         *  quadratic. After a few iterations we will be very to close a root.*/
        return xn;
    }
    /*  End of root.                                                          */

    /*  Main routine used for testing our Steffensen implementation.          */
    static public void main(String[] args)
    {
        /*  Our guess point for sqrt(2). 2 is close enough for Steffensen's   *
         *  method to work.                                                   */
        final double x = 2.0;

        /*  Create a function that evaluates 2 - x^2. sqrt(2) is a root.      */
        Function func = new Function()
        {
            public double evaluate(double x)
            {
                return 2.0 - x*x;
            }
        };

        /*  Calculate the square root and print it to the screen. If we have  *
         *  written things correctly we should get 1.414..., which is sqrt(2).*/
        double sqrt_2 = Steffensen.root(func, x);
        System.out.printf("pi = %.16f\n", sqrt_2);
    }
}
