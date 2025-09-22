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
 *  Function:                                                                 *
 *      distance                                                              *
 *  Purpose:                                                                  *
 *      Computes the distance between a point in the xy plane at the current  *
 *      time and a charge oscillating in the z axis at the retarded time.     *
 *  Arguments:                                                                *
 *      rho (double):                                                         *
 *          The distance from the point to the origin.                        *
 *      retarded_time (double):                                               *
 *          The time for the charge oscillating in the z axis.                *
 *  Output:                                                                   *
 *      dist (double):                                                        *
 *          The distance from the point to the location of the charge at the  *
 *          retarded time.                                                    *
 *  Called Functions:                                                         *
 *      math.h:                                                               *
 *          sqrt:                                                             *
 *              Computes the square root of a double precision real number.   *
 *          sin:                                                              *
 *              Computes the sine of a double precision real number.          *
 *  Method:                                                                   *
 *      If the position for the charge at the retarded time tr is known,      *
 *      r(tr), and if the point in the xy plane at the current time is        *
 *      rho(t), then the distance is computed by using the Euclidean formula  *
 *      with respect to these two points at their respective times:           *
 *                                                                            *
 *          dist = || r(tr) - rho(t) ||                                       *
 *                                                                            *
 *      For a charge oscillating in the z axis, we have:                      *
 *                                                                            *
 *          r(tr) = (0, 0, sin(tr))                                           *
 *                                                                            *
 *      The distance is therefore:                                            *
 *                                                                            *
 *          dist = sqrt(|| rho(t) ||^2 + sin(tr)^2)                           *
 *                                                                            *
 *      This formula is evaluated and the distance is returned.               *
 *  Notes:                                                                    *
 *      The second argument is the retarded time, not the actual time.        *
 ******************************************************************************
 *  Author: Ryan Maguire                                                      *
 *  Date:   2025/09/20                                                        *
 ******************************************************************************/

/*  Function prototype / forward declaration provided here.                   */
#include "heaviside_feynman.h"

/*  Trigonometric functions, like sine, are found here.                       */
#include <math.h>

/*  Function for computing the distance from a point to an oscillating charge.*/
double distance(double rho, double retarded_time)
{
    /*  The charge oscillates in the z-axis. The height is given as follows:  */
    const double height = sin(retarded_time);

    /*  The square of the height is needed for the distance.                  */
    const double height_squared = height * height;

    /*  The input for the point in the xy plane is given in polar coordinates.*
     *  The field is radially symmetric, so only the radius is needed. We     *
     *  need the square of this value to use the Pythagoras formula.          */
    const double rho_squared = rho * rho;

    /*  By Pythagoras, the Euclidean distance is the square root of the sum   *
     *  of the squares. Return this value.                                    */
    return sqrt(rho_squared * height_squared);
}
/*  End of distance.                                                          */
