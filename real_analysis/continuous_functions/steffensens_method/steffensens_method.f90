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
!       Calculates roots using Steffensen's method.                            !
!------------------------------------------------------------------------------!
!   Author: Ryan Maguire                                                       !
!   Date:   2025/05/25                                                         !
!------------------------------------------------------------------------------!
MODULE STEFFENSEN

    IMPLICIT NONE

    ! Steffensen's method is iterative. The convergence is quadratic, meaning
    ! the number of accurate decimals doubles with each iteration. Because of
    ! this we can halt the algorithm after a few steps.
    INTEGER :: MAXIMUM_NUMBER_OF_ITERATIONS = 16

    ! Maximum allowed error. This is 4x double precision epsilon.
    REAL :: EPSILON = 8.881784197001252E-16

    CONTAINS

    !--------------------------------------------------------------------------!
    !   Function:                                                              !
    !       STEFFENSENS_METHOD                                                 !
    !   Purpose:                                                               !
    !       Computes roots using Steffensen's method.                          !
    !   Arguments:                                                             !
    !       FUNC (FUNCTION):                                                   !
    !           A function f: R -> R.                                          !
    !       X (REAL):                                                          !
    !           The initial guess for the root of func.                        !
    !   OUTPUT:                                                                !
    !       ROOT (REAL):                                                       !
    !           A root for FUNC.                                               !
    !--------------------------------------------------------------------------!
    FUNCTION STEFFENSENS_METHOD(FUNC, X)

        IMPLICIT NONE

        ! FUNC is a function f: R -> R. Define this.
        INTERFACE
            FUNCTION FUNC(X)
                IMPLICIT NONE
                REAL, INTENT(IN) :: X
                REAL :: FUNC
            END FUNCTION FUNC
        END INTERFACE

        ! The input is a real number, the guess for Steffensen's method.
        REAL, INTENT(IN) :: X

        ! The output is also a positive real number, the root of FUNC.
        REAL :: STEFFENSENS_METHOD

        ! Dummy variable for keeping track of how many iterations we've done.
        INTEGER :: ITERS

        ! Steffensen's method is similar to Newton's method. At each step we
        ! Calculate the function F evaluated at the new approximation, and
        ! also compute a function G that acts as the derivative of F. Provide
        ! variables for these two evaluations.
        REAL :: F_XN, G_XN

        ! Variable for the updated approximations.
        REAL :: XN

        ! Steffensen's method starts the process at the guess point.
        XN = X

        ! Iteratively perform Steffensen's method.
        DO ITERS = 0, MAXIMUM_NUMBER_OF_ITERATIONS

            ! Steffensen's method needs the evaluations f(x) and f(x + f(x)),
            ! in particular the denominator is f(x + f(x)) / f(x) - 1.
            F_XN = FUNC(XN)
            G_XN = FUNC(XN + F_XN) / F_XN - 1.0

            ! Like Newton's method the new point is obtained by subtracting
            ! the ratio. g(x) = f(x + f(x))/f(x) - 1 acts as the derivative
            ! of f, but we do not explicitly need to calculate f'(x).
            XN = XN - F_XN / G_XN

            ! If f(x) is very small, we are close to a root and can break
            ! out of this loop. Check for this.
            IF (ABS(F_XN) .LE. EPSILON) THEN
                EXIT
            END IF

        END DO

        ! Like Newton's method, and like Heron's method, the convergence is
        ! quadratic. After a few iterations we will be very to close a root.
        STEFFENSENS_METHOD = XN
    END FUNCTION STEFFENSENS_METHOD

    ! Provide the function f(x) = 2 - x^2. sqrt(2) is a root.
    FUNCTION FUNC(X)

        IMPLICIT NONE
        REAL, INTENT(IN) :: X
        REAL :: FUNC
        FUNC = 2.0 - X * X

    END FUNCTION FUNC

END MODULE STEFFENSEN

! Program for testing our implementation of Steffensen's method.
PROGRAM MAIN

    USE STEFFENSEN
    IMPLICIT NONE

    ! 2 is close enough to sqrt(2) for Steffensen's method to converge.
    REAL :: X = 2.0

    ! Variable for the output.
    REAL :: SQRT_2

    ! Run the routine, compute sqrt(2), and print the result.
    SQRT_2 = STEFFENSENS_METHOD(FUNC, X)
    PRINT "(A,F18.16)", "sqrt(2) = ", SQRT_2

END PROGRAM MAIN
