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
    const double start = 1.0;
    const double end = 15.0;
    const double dx = 1.0E-6;
    const double current_time = 1.0;

    const size_t number_of_samples = (size_t)((end - start) / dx);

    double err, time;
    double x = start;
    size_t n;

    clock_t t0, t1;

    double *tr = malloc(sizeof(*tr) * number_of_samples);

    if (!tr)
    {
        puts("malloc failed and returned NULL.");
        return;
    }

    t0 = clock();

    for (n = 0; n < number_of_samples; ++n)
    {
        tr[n] = test(current_time, x, iters);
        x += dx;
    }

    t1 = clock();

    time = (double)(t1 - t0) / CLOCKS_PER_SEC;

    x = start;
    err = 0.0;

    for (n = 0; n < number_of_samples; ++n)
    {
        const double actual = past_halley(current_time, x, 8);
        const double tmp = (actual - tr[n]) / actual;

        if (err < tmp)
            err = tmp;

        x += dx;
    }

    free(tr);

    printf("%u Iterations - Time: %.4E - Error: %.4E\n", iters, time, err);
}

