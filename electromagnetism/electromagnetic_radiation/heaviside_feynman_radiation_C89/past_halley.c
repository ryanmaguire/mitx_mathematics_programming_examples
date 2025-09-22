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
 *      past_halley                                                           *
 *  Purpose:                                                                  *
 *      Given a point in the xy plane and the time at this point, this        *
 *      computes the retarded time for a charge oscillating in the z axis by  *
 *      iteratively applying Halley's method.                                 *
 *  Arguments:                                                                *
 *      rho (double):                                                         *
 *          The distance from the point to the origin.                        *
 *      time (double):                                                        *
 *          The time for the point in the plane.                              *
 *      iters (unsigned int):                                                 *
 *          The number of iterations that will be performed.                  *
 *  Output:                                                                   *
 *      retarded_time (double):                                               *
 *          The time for the oscillating charge.                              *
 *  Called Functions:                                                         *
 *      heaviside_feynman.h:                                                  *
 *          halley:                                                           *
 *              Computes the Halley iterate for the retarded time.            *
 *  Method:                                                                   *
 *      Iteratively apply Halley's method with the guess t0 = t - rho.        *
 ******************************************************************************
 *  Author: Ryan Maguire                                                      *
 *  Date:   2025/09/20                                                        *
 ******************************************************************************/

/*  Function prototype / forward declaration provided here.                   */
#include "heaviside_feynman.h"

/*  Function for computing the retarded time for an oscillating charge.       */
double past_halley(double rho, double time, unsigned int iters)
{
    /*  The charge is oscillating in the z axis between -1 and 1. The time it *
     *  takes for light to travel from the origin to the point is a good      *
     *  approximation to the actual light travel time.                        */
    double tn = time - rho;

    /*  Variable for indexing over the loop for Halley's method.              */
    unsigned int ind;

    /*  Loop through and iteratively apply Halley's method.                   */
    for (ind = 0; ind < iters; ++ind)
        tn = halley(rho, time, tn);

    /*  If iters is large enough, we have a very good approximation.          */
    return tn;
}
/*  End of past_halley.                                                       */
