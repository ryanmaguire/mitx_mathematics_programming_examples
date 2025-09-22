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
 *      newton                                                                *
 *  Purpose:                                                                  *
 *      Given a point in the xy plane, the time at this point, and a guess    *
 *      for the retarded time for a point charge oscillating in the z axis,   *
 *      this computes an improved guess using Newton's method. If the speed   *
 *      of light is c = 1, a good guess for the retarded time is time - rho.  *
 *  Arguments:                                                                *
 *      rho (double):                                                         *
 *          The distance from the point to the origin.                        *
 *      time (double):                                                        *
 *          The time for the point in the plane.                              *
 *      guess (double):                                                       *
 *          A guess for the time of the charge oscillating in the z axis.     *
 *  Output:                                                                   *
 *      retarded_time (double):                                               *
 *          An improved guess of the time for the oscillating charge.         *
 *  Called Functions:                                                         *
 *      math.h:                                                               *
 *          sqrt:                                                             *
 *              Computes the square root of a double precision real number.   *
 *          cos:                                                              *
 *              Computes the cosine of a double precision real number.        *
 *          sin:                                                              *
 *              Computes the sine of a double precision real number.          *
 *  Method:                                                                   *
 *      The retarded time for the oscillating charge with respect to the time *
 *      for the point in the xy plane is given by:                            *
 *                                                                            *
 *                   1                                                        *
 *          t  = t - - || r(t ) - rho(t) ||                                   *
 *           r       c       r                                                *
 *                                                                            *
 *      Where r is the position vector for the charge, rho is the point in    *
 *      the xy plane, t_r is the retarded time, t is the actual time (which   *
 *      is the time for the point in the plane), and c is the speed of light. *
 *      Unfortunately, this expression is not directly computable since we    *
 *      have written t_r as a function of t_r since r varies as a function of *
 *      the retarded time. We move everything over to one side:               *
 *                                                                            *
 *                   1                                                        *
 *          t  - t + - || r(t ) - rho(t) || = 0                               *
 *           r       c       r                                                *
 *                                                                            *
 *      And now we see that solving for the retarded time is equivalent to    *
 *      finding a root for f(t_r) = t_r - t + (1/c) || r(t_r) - rho(t) ||.    *
 *      This is done using Newton's method. Given a guess, we obtain an       *
 *      improved guess via:                                                   *
 *                                                                            *
 *                     f(t0)                                                  *
 *          t1 = t0 - -------                                                 *
 *                     f'(t0)                                                 *
 *                                                                            *
 *      where t0 is the guess, and t1 is the improved guess. This is the      *
 *      so-called Newton iterate. This function evaluates this expression.    *
 *  Notes:                                                                    *
 *      A good initial guess is t0 = t - || rho || / c.                       *
 ******************************************************************************
 *  Author: Ryan Maguire                                                      *
 *  Date:   2025/09/20                                                        *
 ******************************************************************************/

/*  Function prototype / forward declaration provided here.                   */
#include "heaviside_feynman.h"

/*  Trigonometric functions and the square root function given here.          */
#include <math.h>

/*  Function for computing the Newton iterate for the retarded time.          */
double newton(double rho, double time, double guess)
{
    /*  The point charge oscillates in the z axis, the height is given by the *
     *  sine of the guess for the retarded time.                              */
    const double sin_tr = sin(guess);

    /*  Newton's method uses the derivative, so the cosine is needed too.     */
    const double cos_tr = cos(guess);

    /*  Compute the Euclidean distance from the point in the plane to the     *
     *  location of the oscillating charge at the guess for the retarded time.*/
    const double dist = sqrt(rho * rho + sin_tr * sin_tr);

    /*  We are trying to solve for:                                           *
     *                                                                        *
     *               1                                                        *
     *      t  - t + - || r(t ) - rho(t) || = 0                               *
     *       r       c       r                                                *
     *                                                                        *
     *  meaning we are looking for a root to:                                 *
     *                                                                        *
     *                         1                                              *
     *      f(t_r) = t_r - t + - || r(t_r) - rho(t) ||                        *
     *                         c                                              *
     *                                                                        *
     *  Newton's method needs f(t0) and f'(t0), where t0 is the guess. We use *
     *  c = 1, for simplicity.                                                */
    const double func = guess - time + dist;

    /*  The derivative is:                                                    *
     *                                                                        *
     *           -                                 -                          *
     *       d  |          1                        |                         *
     *      --- | t  - t + - || r(t_r) - rho(t) ||  |                         *
     *      dt  |  r       c                        |                         *
     *        r  -                                 -                          *
     *                                                                        *
     *                   -     ---------------- -                             *
     *            1  d  |     /        2     2   |                            *
     *      = 1 + - --- | \  /  sin(t ) + rho    |                            *
     *            c dt  |  \/        r           |                            *
     *                r  -                      -                             *
     *                                                                        *
     *               sin(t ) cos(t )                                          *
     *                    r       r                                           *
     *      = 1 + ---------------------                                       *
     *                 ----------------                                       *
     *                /        2     2                                        *
     *            \  /  sin(t ) + rho                                         *
     *             \/        r                                                *
     *                                                                        *
     *  This is the denominator for Newton's method.                          */
    const double deriv = 1.0 + sin_tr * cos_tr / dist;

    /*  Return the Newton iterator, t0 - f(t0) / f'(t0).                      */
    return guess - func / deriv;
}
/*  End of newton.                                                            */
