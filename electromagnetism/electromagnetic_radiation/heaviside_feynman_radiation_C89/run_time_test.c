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
 *  Date:   2025/09/22                                                        *
 ******************************************************************************/

/*  Function prototype / forward declaration provided here.                   */
#include "heaviside_feynman.h"

/*  printf found here, used for printing to the screen.                       */
#include <stdio.h>

/*  malloc and free are found here, used for managing memory.                 */
#include <stdlib.h>

/*  Timing tools, using for seeing how long a method takes to run.            */
#include <time.h>

/*  Function for benchmarking the performance of various methods.             */
void run_time_test(error_test test, unsigned int iters)
{
    /*  This test benchmarks the performance of the numerical method. We hold *
     *  the time fixed and vary the distance to the origin. The animation     *
     *  generated using the three.js code have rho vary from 1 to 16. We'll   *
     *  time these functions over the same interval.                          */
    const double start = 1.0;
    const double end = 16.0;

    /*  Step size between samples. This is made small to get a good benchmark.*/
    const double dx = 1.0E-6;

    /*  The fixed time for the test.                                          */
    const double current_time = 1.0;

    /*  The total number of samples we are testing, given by the start and    *
     *  end points, together with the step size between samples.              */
    const size_t number_of_samples = (size_t)((end - start) / dx);

    /*  Variables for the error in the computation and the total time needed. */
    double err, time;

    /*  Initialize the test to the start of the interval.                     */
    double x = start;

    /*  Variable for indexing over the points in the interval.                */
    size_t ind;

    /*  Variables for timing how long the for-loop takes to run.              */
    clock_t t0, t1;

    /*  Allocate memory for the output of the test. We do this so that we     *
     *  may loop over the results and compute the maximum error. Performing   *
     *  this error calculation in the for-loop for tr would mean we are       *
     *  timing both the tr computation and the error. This way we are only    *
     *  timing the calculation of tr, the error portion is not timed.         */
    double *tr = malloc(sizeof(*tr) * number_of_samples);

    /*  malloc returns NULL on failure. Check for this.                       */
    if (!tr)
    {
        puts("malloc failed and returned NULL.");
        return;
    }

    /*  Start the timer.                                                      */
    t0 = clock();

    /*  Loop through the samples and perform the numerical method.            */
    for (ind = 0; ind < number_of_samples; ++ind)
    {
        tr[ind] = test(current_time, x, iters);
        x += dx;
    }

    /*  Stop the timer.                                                       */
    t1 = clock();

    /*  Compute the total computation time for the tr for-loop.               */
    time = (double)(t1 - t0) / CLOCKS_PER_SEC;

    /*  Reset the point back to the start of the interval so that we may      *
     *  compute the maximum error.                                            */
    x = start;

    /*  Initialize the error as well. We will update this as we loop through  *
     *  the tr array.                                                         */
    err = 0.0;

    /*  This for-loop serves two purposes. For one, it computes the maximum   *
     *  error in our calculation. More importantly, it prevents a compiler    *
     *  from optimizing away the entire test. If we only ran the tr for-loop  *
     *  and then never used the data, a compiler may see this and skip the    *
     *  entire calculation. The resulting time would be close to zero, but    *
     *  this is not an accurate benchmark. By checking the error we prevent   *
     *  the compiler from doing this, allowing us to get a valid benchmark.   */
    for (ind = 0; ind < number_of_samples; ++ind)
    {
        /*  Six iterations of Halley's method gets us to double precision.    */
        const double actual = past_halley(current_time, x, 6);

        /*  Compute the error for the current point.                          */
        const double tmp = (actual - tr[ind]) / actual;

        /*  If the error increased, update the maximum error variable.        */
        if (err < tmp)
            err = tmp;

        /*  Move on to the next sample.                                       */
        x += dx;
    }

    /*  Print the results: computation time, and maximum error.               */
    printf("%u Iterations - Time: %.4E - Error: %.4E\n", iters, time, err);

    /*  We're done with the memory, free it to avoid memory leaks.            */
    free(tr);
}
/*  End of run_time_test.                                                     */
