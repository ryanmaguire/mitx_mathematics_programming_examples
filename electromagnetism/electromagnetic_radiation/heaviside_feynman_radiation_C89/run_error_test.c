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
 *  Author: Ryan Maguire                                                      *
 *  Date:   2025/09/20                                                        *
 ******************************************************************************/

/*  Function prototype / forward declaration provided here.                   */
#include "heaviside_feynman.h"

/*  FILE data type found here, and functions for writing data to a file.      */
#include <stdio.h>

/*  Function for testing one of the numerical methods for retarded time.      */
void run_error_test(error_test test, double rho, const char * filename)
{
    /*  The point charge oscillated with period 2 pi. We'll run the test over *
     *  an equally sampled data set over this interval.                       */
    const double start = 0.0;
    const double end = 6.283185307179586;

    /*  Step size between samples.                                            */
    const double dt = 1.0E-3;

    /*  Initialize the test to the start of the time interval.                */
    double t = start;

    /*  Create a file and give it write permissions.                          */
    FILE *fp = fopen(filename, "w");

    /*  fopen returns NULL on failure. Check for this.                        */
    if (!fp)
    {
        puts("fopen failed and returned NULL.");
        return;
    }

    /*  Loop through the interval and run the test.                           */
    while (t < end)
    {
        /*  Perform the numerical method for 0, 1, 2, and 8 iterations. Eight *
         *  iterations is enough for both Newton and Halley's method to       *
         *  converge to within double precision.                              */
        const double tr0 = test(rho, t, 0);
        const double tr1 = test(rho, t, 1);
        const double tr2 = test(rho, t, 2);
        const double tr = test(rho, t, 8);

        /*  Write the results to the CSV file.                                */
        fprintf(fp, "%E, %E, %E, %E\n", tr0, tr1, tr2, tr);

        /*  Update the time to the next sample.                               */
        t += dt;
    }

    /*  We're done writing to the file, close it.                             */
    fclose(fp);
}
/*  End of run_error_test.                                                    */
