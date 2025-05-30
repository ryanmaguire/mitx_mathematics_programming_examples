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

/*  Console.WriteLine and Math.Abs are both provided here.                    */
using System;

/*  Class providing an implementation of Heron's method.                      */
class Heron {

    /*  Heron's method is iterative and the convergence is quadratic. This    *
     *  means that if a_{n} has N correct decimals, then a_{n+1} will have    *
     *  2N correct decimals. A standard 64-bit double can fit about 16        *
     *  decimals of precision (the exact value is 2^-52 ~= 2.22x10^-16).      *
     *  Because of this we may exit the function after a few iterations.      *
     *                                                                        *
     *  Note:                                                                 *
     *      We are declaring the following integer as "unsigned" meaning      *
     *      non-negative. The "U" after the number is the suffix for unsigned *
     *      constants in C#. It simply means unsigned.                        */
    const uint maximumNumberOfIterations = 16U;

    /*  The maximum allowed error. This is 4x double precision epsilon.       */
    const double epsilon = 8.881784197001252E-16;

    /*  Computes square roots using Heron's method.                           */
    static double HeronsMethod(double x)
    {
        /*  Dummy variable for keeping track of the number of iterations.     */
        uint iters;

        /*  Initial approximation for Heron's method. Choose the input.       */
        double approximateRoot = x;

        /*  Loop through and iteratively apply Heron's method.                */
        for (iters = 0; iters < maximumNumberOfIterations; ++iters)
        {
            /*  If we are within epsilon of the correct value we may break    *
             *  break out of this for-loop. Check for this.                   */
            double error = (x - approximateRoot * approximateRoot) / x;

            if (Math.Abs(error) < epsilon)
                break;

            /*  Otherwise, improve our approximation using Heron's method.    */
            approximateRoot = 0.5 * (approximateRoot + x / approximateRoot);
        }

        /*  Provided x is positive and not very large, we should have an      *
         *  excellent approximation for sqrt(x). Heron's method does indeed   *
         *  work for large x, but we may need to increase the value of        *
         *  maximumNumberOfIterations.                                        */
        return approximateRoot;
    }
    /*  End of HeronsMethod.                                                  */

    /*  Routine for testing our implementation of Heron's method.             */
    static void Main()
    {
        /*  Compute sqrt(2) using Heron's method and print the result.        */
        double x = 2.0;
        double sqrtX = HeronsMethod(x);
        Console.WriteLine($"sqrt({x}) = {sqrtX}");
    }
}

/*  On Windows you can use Microsoft's C# compiler. Type:                     *
 *      csc herons_method.cs -out:main.exe                                    *
 *      main.exe                                                              *
 *  This will output:                                                         *
 *      sqrt(2) = 1.41421356237309                                            *
 *  This has a relative error of 3.611212654972683e-15. Note, csc only prints *
 *  a double to 15 decimals, the last digit is rounded.                       *
 *                                                                            *
 *  On GNU, Linux, FreeBSD, macOS, etc., you can use the mono C# compiler:    *
 *      mcs herons_method.cs -out:main                                        *
 *      ./main                                                                *
 *  This produces the same result.                                            */
