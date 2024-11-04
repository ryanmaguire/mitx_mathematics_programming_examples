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
 *      Provides basic syntax for complex numbers using the C99 standard.     *
 ******************************************************************************
 *  Author: Ryan Maguire                                                      *
 *  Date:   2024/11/04                                                        *
 ******************************************************************************/

/*  Complex numbers and complex functions are found here.                     */
#include <complex.h>

/*  The printf function, used for printing messages, provided here.           */
#include <stdio.h>

int main(void)
{
    /*  C provides the variable "_Complex_I" which is the imaginary unit.     *
     *  Let us label this as "i" to make this program easier to read. The     *
     *  expression (complex double) that appears before the variable just     *
     *  means we want our variable to be complex and "double" precision,      *
     *  which is computer-talk for numbers that have decimal points (as       *
     *  opposed to integers which don't have decimal points).                 */
    complex double i = (complex double)_Complex_I;

    /*  We can now create the complex number z = 1 + i.                       */
    complex double z = 1 + i;

    /*  complex.h provides creal and cimag, which compute the real and        *
     *  imaginary parts of a complex number.                                  */
    double x = creal(z);
    double y = cimag(z);

    /*  We can also compute the modulus and the principal argument using the  *
     *  standard library. complex.h provides "cabs" and "carg".               */
    double r = cabs(z);
    double theta = carg(z);

    /*  Let's print our work to the screen. printf works as follows. It takes *
     *  a "formatted string", which is a bunch of characters that form the    *
     *  message we want to print. By formatted, we mean that every time we    *
     *  want to print a (double) variable, we write %f. After our message is  *
     *  done, we pass the variables to the function in the order they appear  *
     *  in the message. So:                                                   *
     *      "z = %f + %f i", x, y                                             *
     *  will print z = 1.0 + 1.0 i, instead of printing z = x + i y. That is, *
     *  by using this formatting we can print the value of the variable, and  *
     *  not the variable itself.                                              *
     *                                                                        *
     *  Note that our message ends with "\n" which means means "new-line."    *
     *  This is equivalent to hitting the enter key to move on to the next    *
     *  line in a text.                                                       */
    printf("z = %f + %f i\n", x, y);

    /*  We can print the polar form as well.                                  */
    printf("|z| = |%f + %f i| = %f\n", x, y, r);
    printf("Arg(z) = Arg(%f + %f i) = %f\n", x, y, theta);

    /*  We are done with the function. "return 0" tells the function to exit. */
    return 0;
}
