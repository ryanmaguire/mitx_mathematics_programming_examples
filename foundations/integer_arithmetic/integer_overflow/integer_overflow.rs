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

/*  Computes the number of bits used for unsigned integers.                   */
fn get_number_of_bits() -> u32 {

    /*  Variables for keeping track of the largest power of two possible for  *
     *  unsigned integers. Rust has fixed-width 32-bit integers.              */
    let mut exponent: u32 = 0;
    let mut power_of_two: u32 = 1;

    /*  We start with power_of_two = 1 and iteratively multiply by two. After *
     *  enough iterations, this will overflow and we will get zero.           */
    while power_of_two != 0 {

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

/*  Computes the largest number possible for unsigned integers.               */
fn get_max_number() -> u32 {

    /*  We will compute the maximum number for unsigned int as follows:       *
     *                                                                        *
     *            N - 1                                                       *
     *            -----                                                       *
     *            \      n                                                    *
     *      max = /     2                                                     *
     *            -----                                                       *
     *            n = 0                                                       *
     *                                                                        *
     *  where N is the number of bits in the unsigned integer type. That is,  *
     *  we create the number that is all 1 in binary and number-of-bits long. */
    let number_of_bits: u32 = get_number_of_bits();

    /*  We start the sum at zero and compute it iteratively.                  */
    let mut max_integer: u32 = 0;

    /*  Variable for computing 2^n as n varies from 0 to number_of_bits - 1.  */
    let mut two_to_the_n: u32;

    /*  Loop through the bits and perform the sum.                            */
    for index in 0 .. number_of_bits {

        /*  We compute 2^n by bit-shifting 1 by n bits. Consider the same     *
         *  idea but in decimal. If you have 10.00 and want one hundred, you  *
         *  would simply shift the decimal over by one, obtaining 100.0. This *
         *  is the binary equivalent of that idea. wrapping_shl, which is the *
         *  "wrapping-shift-left" method, allows for shifting to overflow, or *
         *  "wrap", in Rust.                                                  */
        two_to_the_n = 1u32.wrapping_shl(index);

        /*  Add this power of two to the output. wrapping_add also allows one *
         *  to add with wrapping enabled.                                     */
        max_integer = max_integer.wrapping_add(two_to_the_n);
    }

    /*  max_integer is now 111....111_2, in binary, with number_of_bits 1's.  */
    return max_integer;
}
/*  End of get_max_number.                                                    */

/*  A short program for testing our functions.                                */
fn main() {

    /*  Compute the number of bits and the max number using our functions.    */
    let number_of_bits: u32 = get_number_of_bits();
    let max_number: u32 = get_max_number();

    /*  If we add 1 to the max number, it will overflow to zero. Let's see.   *
     *  Rust will catch overflows and stop the program by default unless we   *
     *  use wrapping_add. Use this instead of the "+" symbol.                 */
    let max_number_plus_one: u32 = max_number.wrapping_add(1);

    /*  Print all of the results to the screen.                               */
    println!("Total Number of Bits: {}", number_of_bits);
    println!("Largest Integer Value: {}", max_number);
    println!("Largest Value Plus One: {}", max_number_plus_one);
}
