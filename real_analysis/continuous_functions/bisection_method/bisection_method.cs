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
 *      Calculates the root of a function using the bisection method.         *
 ******************************************************************************
 *  Author: Ryan Maguire                                                      *
 *  Date:   2025/03/28                                                        *
 ******************************************************************************/

/*  Console.WriteLine and Math.Abs are both provided here.                    */
using System;

/*  Create an alias for functions of the form f: R -> R.                      */
using function = System.Func<double, double>;

/*  Class providing an implementation of the bisection method.                */
class Bisection {

    /*  The error after n iterations is |b - a| / 2^n. Since double has a     *
     *  52-bit mantissa, if |b - a| ~= 1, then after 52 steps we can halt the *
     *  program. To allow for |b - a| to be larger, we stop the process after *
     *  at most 64 iterations.                                                */
    const uint maximumNumberOfIterations = 64U;

    /*  The maximum allowed error. This is double precision epsilon.          */
    const double epsilon = 2.220446049250313E-16;

    /*  Computes the root of a function using the bisection method.           */
    static double Root(function f, double a, double b)
    {
        /*  Variable for keeping track of the number of iterations.           */
        uint iters;

        /*  The midpoint for the bisection. This updates as we iterate.       */
        double midpoint;

        /*  We do not require a < b, nor f(a) < f(b). We need one of          *
         *  these to evaluate negative under f and one to evaluate to         *
         *  positive. Call the negative entry left and positive one right.    */
        double left, right;

        /*  Evaluate f at the endpoints to determine which is positive        *
         *  and which is negative, transforming [a, b] to [left, right].      */
        double aEval = f(a);
        double bEval = f(b);

        /*  Rare case, f(a) = 0. Return a, no bisection needed.               */
        if (aEval == 0.0)
            return a;

        /*  Similarly, if f(b) = 0, then we found the root. Return b.         */
        if (bEval == 0.0)
            return b;

        /*  Compare the two evaluations and set the left and right values.    */
        if (aEval < bEval)
        {
            /*  If both evaluations are negative, or if both are positive,    *
             *  then the bisection method will not work. Return NaN.          */
            if (bEval < 0.0 || aEval > 0.0)
                return (a - a) / (a - a);

            /*  Otherwise, since f(a) < f(b), set left = a and right = b.     */
            left = a;
            right = b;
        }

        /*  In this case the function starts positive and goes negative.      */
        else
        {
            /*  Same sanity check as before. We need one evaluation to be     *
             *  negative and one to be positive. Abort if the signs agree.    */
            if (aEval < 0.0 || bEval > 0.0)
                return (a - a) / (a - a);

            /*  Since f(a) > f(b), set left = b and right = a.                */
            left = b;
            right = a;
        }

        /*  Start the bisection method. Compute the midpoint of a and b.      */
        midpoint = 0.5 * (a + b);

        /*  Iteratively divide the range in half to find the root.            */
        for (iters = 0; iters < maximumNumberOfIterations; ++iters)
        {
            /*  If f(x) is very small, we are close to a root and can         *
             *  break out of this for loop. Check for this.                   */
            double eval = f(midpoint);

            if (Math.Abs(eval) <= epsilon)
                break;

            /*  Apply bisection to get a better approximation. We have        *
             *  f(left) < 0 < f(right). If f(midpoint) < 0, replace the       *
             *  interval [left, right] with [midpoint, right]. Set left       *
             *  to the midpoint and set midpoint to be closer to right.       */
            if (eval < 0.0)
            {
                left = midpoint;
                midpoint = 0.5 * (midpoint + right);
            }

            /*  If f(midpoint) > 0, then replace right with the midpoint,     *
             *  changing [left, right] into [left, midpoint]. We then set     *
             *  the midpoint to be closer to left.                            */
            else
            {
                right = midpoint;
                midpoint = 0.5 * (left + midpoint);
            }
        }

        /*  After n iterations, we are at most |b - a| / 2^n from the         *
         *  root of the function. 1 / 2^n goes to zero very quickly,          *
         *  meaning the convergence is very quick.                            */
        return midpoint;
    }
    /*  End of root.                                                          */

    /*  Main routine used for testing our Bisection implementation.           */
    static void Main()
    {
        /*  pi is somewhere between 3 and 4, and it is a root to sine.        */
        const double a = 3.0;
        const double b = 4.0;

        /*  Compute pi using bisection. We should get pi = 3.14159...,        *
         *  accurate to about 16 decimals.                                    */
        double pi = Root(Math.Sin, a, b);
        Console.WriteLine($"pi = {pi}");
    }
}
