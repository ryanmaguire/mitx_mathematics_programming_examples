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
 *      Provides routines for working with the Heaviside-Feynman formula and  *
 *      computing retarded and advanced times for an oscillating charge.      *
 ******************************************************************************
 *  Author: Ryan Maguire                                                      *
 *  Date:   2025/09/20                                                        *
 ******************************************************************************/

/*  Include guard to prevent including this file twice.                       */
#ifndef HEAVISIDE_FEYNMAN_H
#define HEAVISIDE_FEYNMAN_H

/******************************************************************************
 *  Function:                                                                 *
 *      distance                                                              *
 *  Purpose:                                                                  *
 *      Given a point in the xy plane, and the retarded time for a charge     *
 *      oscillating in the z axis, this computes the distance between the     *
 *      the given point and the location of the charge at the retarded time.  *
 *  Arguments:                                                                *
 *      rho (double):                                                         *
 *          The distance from the point to the origin.                        *
 *      retarded_time (double):                                               *
 *          The time for the charge oscillating in the z axis.                *
 *  Output:                                                                   *
 *      dist (double):                                                        *
 *          The distance from the point to the location of the charge at the  *
 *          retarded time.                                                    *
 ******************************************************************************/
extern double distance(double rho, double retarded_time);

/******************************************************************************
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
 ******************************************************************************/
extern double advanced_time(double rho, double retarded_time);

/******************************************************************************
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
 ******************************************************************************/
extern double newton(double rho, double time, double guess);

/******************************************************************************
 *  Function:                                                                 *
 *      halley                                                                *
 *  Purpose:                                                                  *
 *      Given a point in the xy plane, the time at this point, and a guess    *
 *      for the retarded time for a point charge oscillating in the z axis,   *
 *      this computes an improved guess using Halley's method. If the speed   *
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
 ******************************************************************************/
extern double halley(double rho, double time, double guess);

/******************************************************************************
 *  Function:                                                                 *
 *      past_newton                                                           *
 *  Purpose:                                                                  *
 *      Given a point in the xy plane and the time at this point, this        *
 *      computes the retarded time for a charge oscillating in the z axis by  *
 *      iteratively applying Newton's method.                                 *
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
 ******************************************************************************/
extern double past_newton(double rho, double time, unsigned int iters);

/******************************************************************************
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
 ******************************************************************************/
extern double past_halley(double rho, double time, unsigned int iters);

/******************************************************************************
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
 *          The number of iterations that will be performed.                  *
 *  Output:                                                                   *
 *      error (double):                                                       *
 *          The error in Newton's method. Ideally, this is close to zero.     *
 ******************************************************************************/
extern double newton_error(double rho, double time, unsigned int iters);

/******************************************************************************
 *  Function:                                                                 *
 *      halley_error                                                          *
 *  Purpose:                                                                  *
 *      This function tests whether or not Halley's method converged after a  *
 *      few iterations. If it did, the output of the past_halley function is  *
 *      the actual retarded time for the moving charge. If it did not, we     *
 *      have an error and need to correct this.                               *
 *  Arguments:                                                                *
 *      rho (double):                                                         *
 *          The distance from the point to the origin.                        *
 *      time (double):                                                        *
 *          The time for the point in the plane.                              *
 *      iters (unsigned int):                                                 *
 *          The number of iterations that will be performed.                  *
 *  Output:                                                                   *
 *      error (double):                                                       *
 *          The error in Halley's method. Ideally, this is close to zero.     *
 ******************************************************************************/
extern double halley_error(double rho, double time, unsigned int iters);

/*  typedef for the function types that perform the error tests.              */
typedef double (*error_test)(double, double, unsigned int);

/******************************************************************************
 *  Function:                                                                 *
 *      run_test                                                              *
 *  Purpose:                                                                  *
 *      Computes the error in the retarded time from a given numerical method *
 *      (Halley or Newton) after 0, 1, 2, 3, and 4 iterations against the     *
 *      the actual retarded time, and prints the output to a file.            *
 *  Arguments:                                                                *
 *      test (error_test):                                                    *
 *          The method for the test (Halley or Newton).                       *
 *      filename (const char *):                                              *
 *          The name of the CSV file the output is written to.                *
 *  Output:                                                                   *
 *      None (void).                                                          *
 ******************************************************************************/
extern void run_test(error_test test, double rho, const char * filename);

#endif
/*  End of include guard.                                                     */
