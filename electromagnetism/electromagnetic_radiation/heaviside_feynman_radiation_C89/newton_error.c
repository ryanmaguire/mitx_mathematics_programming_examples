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
 *      newton_error                                                          *
 *  Purpose:                                                                  *
 *      This function tests whether or not Newton's method converged after a  *
 *      few iterations. If it did, the output of the past_newton function is  *
 *      the actual retarded time for the moving charge. If it did not, we     *
 *      have an error and need to correct this.                               *
 *  Arguments:                                                                *
 *      rho (double):                                                         *
 *          The distance from the point to the origin.                        *
 *      time (double):                                                        *
 *          The time for the point in the plane.                              *
 *      iters (unsigned int):                                                 *
 *          The number of iterations used for Newton's method.                *
 *  Output:                                                                   *
 *      error (double):                                                       *
 *          The error in Newton's method. Ideally, this is close to zero.     *
 *  Called Functions:                                                         *
 *      heaviside_feynman.h:                                                  *
 *          past_newton:                                                      *
 *              Computes retarded time (past time) using Newton's method.     *
 *          distance:                                                         *
 *              Computes the distance between the source charge at the        *
 *              retarded time and the observation point at the current time.  *
 *  Method:                                                                   *
 *      Compute t_r - t + distance / c (but we set c = 1, for simplicity).    *
 ******************************************************************************
 *  Author: Ryan Maguire                                                      *
 *  Date:   2025/09/20                                                        *
 ******************************************************************************/

/*  Function prototype / forward declaration provided here.                   */
#include "heaviside_feynman.h"

/*  Function for computing the error in Newton's method.                      */
double newton_error(double rho, double time, unsigned int iters)
{
    /*  Use Newton's method to compute the retarded time.                     */
    const double retarded_time = past_newton(rho, time, iters);

    /*  Now that we have a guess for the retarded time for the oscillating    *
     *  point charge, we may use this to compute the distance between the     *
     *  point rho in the xy plane and the position of the oscillating charge  *
     *  at the retarded time.                                                 */
    const double dist = distance(rho, retarded_time);

    /*  Retarded time is tr = t - (1 / c) || r(tr) - rho(t) ||. If Newton's   *
     *  method converged, the following expression should be close to zero.   */
    return retarded_time - time + dist;
}
/*  End of newton_error.                                                      */
