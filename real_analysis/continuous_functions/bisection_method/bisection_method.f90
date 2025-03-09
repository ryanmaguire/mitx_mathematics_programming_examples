!------------------------------------------------------------------------------!
!                                   LICENSE                                    !
!------------------------------------------------------------------------------!
!   This file is part of mitx_mathematics_programming_examples.                !
!                                                                              !
!   mitx_mathematics_programming_examples is free software: you can            !
!   redistribute it and/or modify it under the terms of the GNU General Public !
!   License as published by the Free Software Foundation, either version 3 of  !
!   the License, or (at your option) any later version.                        !
!                                                                              !
!   mitx_mathematics_programming_examples is distributed in the hope that it   !
!   will be useful but WITHOUT ANY WARRANTY; without even the implied warranty !
!   of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the           !
!   GNU General Public License for more details.                               !
!                                                                              !
!   You should have received a copy of the GNU General Public License          !
!   along with mitx_mathematics_programming_examples.  If not, see             !
!   <https://www.gnu.org/licenses/>.                                           !
!------------------------------------------------------------------------------!
!   Purpose:                                                                   !
!       Calculates roots using the bisection method.                           !
!------------------------------------------------------------------------------!
!   Author: Ryan Maguire                                                       !
!   Date:   2025/03/09                                                         !
!------------------------------------------------------------------------------!
MODULE BISECTION

    IMPLICIT NONE

    ! Given a continuous function defined on [a, b], the nth iteration of the
    ! bisection method is at most |b - a| / 2^n away from the root. A double
    ! precision number has 52 bits in the mantissa, meaning if |b - a| ~= 1,
    ! then after 52 iterations we are as close to the root as we can get.
    ! To allow for a larger range, halt the algorithm after 64 iterations.
    INTEGER :: MAXIMUM_NUMBER_OF_ITERATIONS = 16

    ! Maximum allowed error. This is double precision epsilon.
    REAL :: EPSILON = 2.220446049250313E-16

    CONTAINS

    !--------------------------------------------------------------------------!
    !   Function:                                                              !
    !       BISECTION_METHOD                                                   !
    !   Purpose:                                                               !
    !       Computes roots using the bisection method.                         !
    !   Arguments:                                                             !
    !       FUNC (FUNCTION):                                                   !
    !           A function from [A, B] to the real numbers.                    !
    !       A (REAL):                                                          !
    !           One of the endpoints for the interval.                         !
    !       B (REAL):                                                          !
    !           The other the endpoint for the interval.                       !
    !   OUTPUT:                                                                !
    !       ROOT (REAL):                                                       !
    !           A root for FUNC.                                               !
    !--------------------------------------------------------------------------!
    FUNCTION BISECTION_METHOD(FUNC, A, B)

        IMPLICIT NONE

        ! FUNC is a function f: [A, B] -> Reals. Define this.
        INTERFACE
            FUNCTION FUNC(X)
                IMPLICIT NONE
                REAL, INTENT(IN) :: X
                REAL :: FUNC
            END FUNCTION FUNC
        END INTERFACE

        ! The inputs are positive real numbers.
        REAL, INTENT(IN) :: A, B

        ! The output is also a positive real number, the root of FUNC.
        REAL :: BISECTION_METHOD

        ! Dummy variable for keeping track of how many iterations we've done.
        INTEGER :: ITERS

        ! The midpoint of the interval. The bisection method iteratively cuts
        ! the interval in half to find the root.
        REAL :: MIDPOINT

        ! The endpoints of the current interval. These are updated with each
        ! iteration. We initially define LEFT so that FUNC(LEFT) < 0, and
        ! similarly choose RIGHT to make 0 < FUNC(RIGHT).
        REAL :: LEFT, RIGHT

        ! The evaluations of A and B are used to determine LEFT and RIGHT.
        REAL :: A_EVAL, B_EVAL

        ! At each iteration we compute FUNC(MIDPOINT) and reset the interval
        ! depending on whether or not the value is positive.
        REAL :: EVAL

        ! Initial setup, find out which evaluation is positive and which is
        ! negative. If the signs of the two agree we treat this as an error.
        A_EVAL = FUNC(A)
        B_EVAL = FUNC(B)

        ! Special case, A is a root. Set the output to A and return.
        IF (ABS(A_EVAL) .LE. EPSILON) THEN
            BISECTION_METHOD = A
            RETURN
        END IF

        ! Similarly for B, if FUNC(B) ~= 0, return B.
        IF (ABS(B_EVAL) .LE. EPSILON) THEN
            BISECTION_METHOD = B
            RETURN
        END IF

        ! If FUNC(A) < 0 < FUNC(B), then LEFT = A and RIGHT = B.
        IF (A_EVAL .LT. B_EVAL) THEN

            ! If FUNC(A) and FUNC(B) have the same sign (both positive or
            ! both negative), return NaN. Bisection is undefined.
            IF ((A_EVAL .GT. 0) .OR. (B_EVAL .LT. 0)) THEN
                BISECTION_METHOD = (A - A) / (A - A)
                RETURN
            END IF

            LEFT = A
            RIGHT = B

        ! If FUNC(B) < 0 < FUNC(A), then LEFT = B and RIGHT = A.
        ELSE

            ! Same sanity check as before, make sure the signs are different.
            IF ((A_EVAL .LT. 0) .OR. (B_EVAL .GT. 0)) THEN
                BISECTION_METHOD = (A - A) / (A - A)
                RETURN
            END IF

            LEFT = B
            RIGHT = A
        END IF

        MIDPOINT = 0.5 * (A + B)

        ! Iteratively perform the bisection method.
        DO ITERS = 0, MAXIMUM_NUMBER_OF_ITERATIONS

            ! The interval is cut in half based on the sign of FUNC(MIDPOINT).
            ! Compute this and compare.
            EVAL = FUNC(MIDPOINT)

            ! If MIDPOINT is close to a root we can exit the function.
            IF (ABS(EVAL) .LE. EPSILON) THEN
                BISECTION_METHOD = MIDPOINT
                RETURN
            END IF

            ! Otherwise, divide the range in half. If EVAL is negative we
            ! replace LEFT with MIDPOINT and move MIDPOINT closer to RIGHT.
            IF (EVAL .LT. 0) THEN
                LEFT = MIDPOINT
                MIDPOINT = 0.5 * (MIDPOINT + RIGHT)

            ! Likewise, if EVAL is positive, replace RIGHT with MIDPOINT and
            ! move MIDPOINT closer to LEFT.
            ELSE
                RIGHT = MIDPOINT
                MIDPOINT = 0.5 * (LEFT + MIDPOINT)
            END IF
        END DO

        ! Provided |B - A| is not too big, we should now have a very good
        ! approximation to the root.
        BISECTION_METHOD = MIDPOINT
    END FUNCTION BISECTION_METHOD
END MODULE BISECTION

! Program for testing our implementation of the bisection method.
PROGRAM MAIN

    USE BISECTION
    IMPLICIT NONE

    ! We will compute pi by finding a root to sine on the interval [3, 4].
    ! The sine function is an intrinsic provided by Fortran.
    INTRINSIC SIN

    ! Pi is somewhere between 3 and 4, use this interval.
    REAL :: A = 3.0
    REAL :: B = 4.0

    ! Variable for the output.
    REAL :: PI

    ! Run the routine, compute pi, and print the result.
    PI = BISECTION_METHOD(SIN, A, B)
    PRINT "(A,F18.16)", "pi = ", PI

END PROGRAM MAIN
