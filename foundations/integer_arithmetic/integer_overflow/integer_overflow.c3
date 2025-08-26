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
 *  Date:   2025/05/29                                                        *
 ******************************************************************************/

/*  std::io provides the "printfn" function, used for printing text.          */
import std::io;

/*  Computes the number of bits used for unsigned int's.                      */
fn int get_number_of_bits()
{
    /*  Variables for keeping track of the largest power of two possible for  *
     *  unsigned integers. C3 uses 32-bit int's and unsigned int's.           */
    int exponent = 0;
    uint power_of_two = 1;

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
fn uint get_max_number()
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
    int number_of_bits = get_number_of_bits();

    /*  We start the sum at zero and compute it iteratively.                  */
    uint max_integer = 0U;

    /*  Variable for looping over the bits of the number.                     */
    int index;

    /*  Variable for computing 2^n as n varies from 0 to number_of_bits - 1.  */
    uint two_to_the_n;

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
fn int main()
{
    /*  Compute the number of bits and the max number using our functions.    */
    int number_of_bits = get_number_of_bits();
    uint max_number = get_max_number();

    /*  If we add 1 to the max number, it will overflow to zero. Let's see.   */
    uint max_number_plus_one = max_number + 1U;

    /*  Print all of the results to the screen. printfn adds a new line, too. */
    io::printfn("Total Number of Bits: %d", number_of_bits);
    io::printfn("Largest Integer Value: %d", max_number);
    io::printfn("Largest Value Plus One: %d", max_number_plus_one);
    return 0;
}
