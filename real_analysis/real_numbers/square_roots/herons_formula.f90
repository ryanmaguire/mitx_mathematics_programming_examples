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
!       Calculates square roots using Heron's method.                          !
!------------------------------------------------------------------------------!
!   Author: Ryan Maguire                                                       !
!   Date:   2025/03/08                                                         !
!------------------------------------------------------------------------------!
MODULE HERON

    IMPLICIT NONE

    ! Heron's method is iterative. The convergence is quadratic, meaning the
    ! number of accurate decimals doubles with each iteration. Because of this
    ! we can halt the algorithm after a few steps.
    INTEGER :: MAXIMUM_NUMBER_OF_ITERATIONS = 16

    ! Maximum allowed error. This is double precision epsilon.
    REAL :: EPSILON = 2.220446049250313E-16

    CONTAINS

    !--------------------------------------------------------------------------!
    !   Function:                                                              !
    !       HERONS_METHOD                                                      !
    !   Purpose:                                                               !
    !       Computes square roots using Heron's method.                        !
    !   Arguments:                                                             !
    !       X (REAL):                                                          !
    !           A positive real number.                                        !
    !   OUTPUT:                                                                !
    !       SQRT_X (REAL):                                                     !
    !           The square root of X.                                          !
    !--------------------------------------------------------------------------!
    FUNCTION HERONS_METHOD(X)

        IMPLICIT NONE

        ! The input is a positive real number.
        REAL, INTENT(IN) :: X

        ! The output is also a positive real number, the square root of X.
        REAL :: HERONS_METHOD

        ! Dummy variable for keeping track of how many iterations we've done.
        INTEGER :: ITERS

        ! Variable used for Heron's approximation. We will iteratively update
        ! this value with better approximations using Heron's method.
        REAL :: APPROXIMATE_ROOT

        ! Variable for tracking the relative error. When this is very small
        ! (less than epsilon) we will break out of the loop and return.
        REAL :: ERROR

        ! Heron's method needs a starting value. Initialize this to the input.
        APPROXIMATE_ROOT = X

        ! Iteratively perform Heron's method.
        DO ITERS = 0, MAXIMUM_NUMBER_OF_ITERATIONS

            ! If the error is small we can break out of this loop.
            ERROR = (X - APPROXIMATE_ROOT * APPROXIMATE_ROOT) / X

            IF (ABS(ERROR) .LT. EPSILON) THEN
                EXIT
            END IF

            ! Otherwise, improve our approximation using Heron's method.
            APPROXIMATE_ROOT = 0.5 * (APPROXIMATE_ROOT + X / APPROXIMATE_ROOT)
        END DO

        ! If x is positive and not too big, APPROXIMATE_ROOT should have a
        ! very accurate approximation to sqrt(x). Heron's method works for
        ! large inputs as well, but we need to increase the value of
        ! MAXIMUM_NUMBER_OF_ITERATIONS.
        HERONS_METHOD = APPROXIMATE_ROOT
    END FUNCTION HERONS_METHOD
END MODULE HERON

! Program for testing our implementation of Heron's method.
PROGRAM MAIN

    USE HERON
    IMPLICIT NONE

    ! The input for the method. We'll compute sqrt(2).
    REAL :: X = 2.0

    ! Variable for the output.
    REAL :: SQRT_X

    ! Run the routine, computing sqrt(x), and print the result.
    SQRT_X = HERONS_METHOD(X)
    PRINT "(A,F3.1,A,F18.16)", "SQRT(", X, ") = ", SQRT_X

END PROGRAM MAIN
