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
 *      Shows that integers addition can overflow, setting back to zero.      *
 ******************************************************************************
 *  Author: Ryan Maguire                                                      *
 *  Date:   2024/12/03                                                        *
 ******************************************************************************/

/*  stdio.h provides the "printf" function, used for printing text.           */
#include <stdio.h>

/*  Computes the number of bits used for unsigned int's.                      */
static int get_number_of_bits(void)
{
    /*  Variables for keeping track of the largest power of two possible for  *
     *  unsigned integers. Most computers use 32-bit int's.                   */
    int exponent = 0;
    unsigned int power_of_two = 1;

    /*  We start with power_of_two = 1 and iteratively multiply by two. After *
     *  enough iterations, this will overflow and we will get zero.           */
    while (power_of_two != 0U)
    {
        /*  Increment the exponent since we haven't overflowed yet.           */
        exponent = exponent + 1;

        /*  C syntax: "x << n" takes x and shifts it up n bits. This is the   *
         *  mathematical equivalent of multiplying x by 2^n. Setting          *
         *  power_of_two equal to power_of_two << 1 will compute the next     *
         *  power of two up.                                                  */
        power_of_two = power_of_two << 1;
    }

    /*  "exponent" now stores the first value N such that 2^N overflows to    *
     *  zero. This is the number of bits used for the number. Return this.    */
    return exponent;
}
/*  End of get_number_of_bits.                                                */

/*  Computes the largest number possible for unsigned int.                    */
static unsigned int get_max_number(void)
{
    /*  We will compute the maximum number for unsigned int as follows:       *
     *                                                                        *
     *            N - 1                                                       *
     *            -----                                                       *
     *            \      n                                                    *
     *      max = /     2                                                     *
     *            -----                                                       *
     *            n = 0                                                       *
     *                                                                        *
     *  where N is the number of bits in unsigned int. That is, we create the *
     *  number that is all ones in binary and is number-of-bits long.         */
    const int number_of_bits = get_number_of_bits();

    /*  We start the sum at zero and compute it iteratively.                  */
    unsigned int max_integer = 0U;

    /*  Variable for looping over the bits of the number.                     */
    int index;

    /*  Variable for computing 2^n as n varies from 0 to number_of_bits - 1.  */
    unsigned int two_to_the_n;

    /*  Loop through the bits and perform the sum.                            */
    for (index = 0; index < number_of_bits; ++index)
    {
        /*  We compute 2^n by bit-shifting 1 by n bits. Consider the same     *
         *  idea but in decimal. If you have 10.00 and want one hundred, you  *
         *  would simply shift the decimal over by one, obtaining 100.0. This *
         *  is the binary equivalent of that idea.                            */
        two_to_the_n = 1 << index;

        /*  Add this power of two to the output.                              */
        max_integer = max_integer + two_to_the_n;
    }

    /*  max_integer is now 111....111_2, in binary, with number_of_bits 1's.  */
    return max_integer;
}
/*  End of get_max_number.                                                    */

/*  A short program for testing our functions.                                */
int main(void)
{
    /*  Compute the number of bits and the max number using our functions.    */
    const int number_of_bits = get_number_of_bits();
    const unsigned int max_number = get_max_number();

    /*  If we add 1 to the max number, it will overflow to zero. Let's see.   */
    const unsigned int max_number_plus_one = max_number + 1U;

    /*  Print all of the results to the screen. printf is found in stdio.h.   */
    printf("Total Number of Bits: %d\n", number_of_bits);
    printf("Largest Integer Value: %u\n", max_number);
    printf("Largest Value Plus One: %u\n", max_number_plus_one);
    return 0;
}

/*  We can execute this on GNU, Linux, FreeBSD, macOS, etc., via:             *
 *      cc integer_overflow.c -o main                                         *
 *      ./main                                                                *
 *  This will output the following:                                           *
 *      Total Number of Bits: 32                                              *
 *      Largest Integer Value: 4294967295                                     *
 *      Largest Value Plus One: 0                                             *
 *  This final line indicates the overflow, we've wrapped around to zero.     *
 *                                                                            *
 *  On Windows you will need to install a C compiler. Common options are      *
 *  Microsoft's MSVC, LLVM's clang, MinGW (which uses the GNU toolchain),     *
 *  or installing Cygwin and running the commands above.                      */
