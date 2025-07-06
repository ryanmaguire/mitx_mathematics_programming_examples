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
 *      Computes z^n for integer n using exponentiation by squaring.          *
 ******************************************************************************
 *  Author: Ryan Maguire                                                      *
 *  Date:   2025/07/06                                                        *
 ******************************************************************************/

/*  Console.WriteLine found here.                                             */
using System;

/*  Complex class defined here.                                               */
using System.Numerics;

/*  Program that implements exponentiation by squaring and tests it out.      */
class Program
{
    /*  Print a complex number in standard form, x + y*i.                     */
    public static void PrintComplex(Complex z)
    {
        Console.WriteLine($"{z.Real} + {z.Imaginary}*i");
    }

    /*  Computes powers of a given complex number by repeatedly squaring.     */
    public static Complex ExpBySquaring(Complex z, int n)
    {
        /*  We start off with out = z, and then apply out = out^2 repeatedly. */
        Complex output = z;

        /*  The scale factor is used to handle odd powers. That is, if we     *
         *  have z^(2n+1), we can write this as z^(2n) * z = (z^2)^n * z. The *
         *  scale factor will pick up the solo "z" term, and the squaring     *
         *  part handles (z^2)^n. Create a variable for this and initialize   *
         *  it to 1.                                                          */
        Complex scale = new Complex(1.0, 0.0);

        /*  Special case. If n = 0, then z^0 = 1, by definition. Return 1.    */
        if (n == 0)
            return scale;

        /*  For negative powers use z^n = (1/z)^(-n) to reduce n to positive. */
        if (n < 0)
        {
            output = 1.0 / output;
            n = -n;
        }

        /*  Start the process. Compute z^n by removing all of the even        *
         *  factors for n, iteratively updating the output along the way.     */
        while (n > 1)
        {
            /*  If n is odd, n = 2*k+1, and if w = output, then:              *
             *                                                                *
             *       n    2k + 1                                              *
             *      w  = w                                                    *
             *                                                                *
             *            -  2 -  n                                           *
             *         = | w    |   * w                                       *
             *            -    -                                              *
             *                                                                *
             *  Multiply "scale" by "output" to handle the "* w" on the right *
             *  side of the expression. We can continue squaring, replacing   *
             *  output with output^2, to handle portion of this expression    *
             *  that is inside of the parentheses.                            */
            if ((n % 2) == 1)
            {
                scale *= output;
                --n;
            }

            /*  n is now even. Square the output and divide n by two.         */
            output *= output;
            n >>= 1;
        }

        /*  n is now 1. The final output is output * scale. Compute this.     */
        return output * scale;
    }

    /*  Let's extend the Complex class by providing the "^" operator.         */
    class ComplexWithPow {

            /*  Complex is a sealed class, we can not inherit from it.        *
             *  Instead, we use composition.                                  */
            private Complex value;

            /*  Create a complex number from two real ones, z = x + i*y.      */
            public ComplexWithPow(double real, double imag)
            {
                this.value = new Complex(real, imag);
            }

            /*  Create a ComplexWithPow object from a complex number.         */
            public ComplexWithPow(Complex z)
            {
                this.value = z;
            }

            /*  Provide the "^" operator for complex numbers. We can then     *
             *  write w = z^n, instead of w = ExpBySquaring(z, n).            */
            public static ComplexWithPow operator ^ (ComplexWithPow z, int n)
            {
                return new ComplexWithPow(ExpBySquaring(z.value, n));
            }

            /*  Provide the print function as a method for the class.         */
            public void Print()
            {
                PrintComplex(this.value);
            }
    }

    /*  Test our routines by computing 1 / (1 + i)^30.                        */
    static void Main()
    {
        const int n = -30;
        ComplexWithPow z = new ComplexWithPow(1.0, 1.0);
        ComplexWithPow w = z^n;
        w.Print();
    }
}
