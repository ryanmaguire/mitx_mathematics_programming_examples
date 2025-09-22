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
 *      advanced_time                                                         *
 *  Purpose:                                                                  *
 *      Given a point in the xy plane, and the time for a point charge        *
 *      oscillating in the z axis, this computes the time when the point will *
 *      see the oscillating charge. This is the so-called advanced time.      *
 *  Arguments:                                                                *
 *      rho (double):                                                         *
 *          The distance from the point to the origin.                        *
 *      retarded_time (double):                                               *
 *          The time for the charge oscillating in the z axis.                *
 *  Output:                                                                   *
 *      time (double):                                                        *
 *          The time when the point sees the charge.                          *
 *  Called Functions:                                                         *
 *      heaviside_feynman.h:                                                  *
 *          distance:                                                         *
 *              Computes the distance between a point in the xy plane and a   *
 *              charge oscillating in the z axis, given the retarded time for *
 *              the oscillating charge.                                       *
 *  Method:                                                                   *
 *      The retarded time for the oscillating charge with respect to the time *
 *      for the point in the xy plane is given by:                            *
 *                                                                            *
 *                   1                                                        *
 *          t  = t - - || r(t ) - rho ||                                      *
 *           r       c       r                                                *
 *                                                                            *
 *      Where t is the time for the point in the plane, t_r is the retarded   *
 *      time, c is the speed of light, r is the position vector for the       *
 *      oscillating charge, and rho is the point in the plane. From this,     *
 *      the advanced time can be obtained by solving for t:                   *
 *                                                                            *
 *                   1                                                        *
 *          t = t  + - || r(t ) - rho ||                                      *
 *               r   c       r                                                *
 *                                                                            *
 *      We use the distance function to compute this expression.              *
 *  Notes:                                                                    *
 *      The second argument is the retarded time, not the actual time.        *
 ******************************************************************************
 *  Author: Ryan Maguire                                                      *
 *  Date:   2025/09/20                                                        *
 ******************************************************************************/

/*  Function prototype / forward declaration provided here.                   */
#include "heaviside_feynman.h"

/*  Function for computing the advanced time of a point in the xy plane.      */
double advanced_time(double rho, double retarded_time)
{
    /*  Compute the distance between the point in the xy plane and the point  *
     *  where the charge was at the retarded time.                            */
    const double dist = distance(rho, retarded_time);

    /*  The advanced time formula simply solves for t using the retarded time *
     *  formula. Compute this and return. Note, we are using c = 1.           */
    return retarded_time + dist;
}
/*  End of advanced_time.                                                     */
