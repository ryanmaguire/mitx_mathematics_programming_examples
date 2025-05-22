;------------------------------------------------------------------------------;
;                                   LICENSE                                    ;
;------------------------------------------------------------------------------;
;   This file is part of mitx_mathematics_programming_examples.                ;
;                                                                              ;
;   mitx_mathematics_programming_examples is free software: you can            ;
;   redistribute it and/or modify it under the terms of the GNU General Public ;
;   License as published by the Free Software Foundation, either version 3 of  ;
;   the License, or (at your option) any later version.                        ;
;                                                                              ;
;   mitx_mathematics_programming_examples is distributed in the hope that it   ;
;   will be useful but WITHOUT ANY WARRANTY; without even the implied warranty ;
;   of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the           ;
;   GNU General Public License for more details.                               ;
;                                                                              ;
;   You should have received a copy of the GNU General Public License          ;
;   along with mitx_mathematics_programming_examples.  If not, see             ;
;   <https://www.gnu.org/licenses/>.                                           ;
;------------------------------------------------------------------------------;
;   Purpose:                                                                   ;
;       Calculates roots using Steffensen's method.                            ;
;------------------------------------------------------------------------------;
;   Author: Ryan Maguire                                                       ;
;   Date:   2025/05/22                                                         ;
;------------------------------------------------------------------------------;
FUNCTION STEFFENSEN, F, X

    ; Tells the compiler that integers should be 32 bits, not 16.
    COMPILE_OPT IDL2

    ; Error checking code.
    ON_ERROR, 2

    ; Steffensen's method is iterative. The convergence is quadratic, meaning
    ; the number of accurate decimals doubles with each iteration. Because of
    ; this we can halt the algorithm after a few steps.
    MAXIMUM_NUMBER_OF_ITERATIONS = 16

    ; Maximum allowed error. This is 4x double precision epsilon.
    EPSILON = 8.881784197001252e-16

    ; Variable used for Steffensen's approximation. We will iteratively update
    ; this value with better approximations using Steffensen's method.
    XN = X

    ; Iteratively perform Steffensen's method.
    FOR ITERS = 1, MAXIMUM_NUMBER_OF_ITERATIONS DO BEGIN

        ; Steffensen's method needs the evaluations f(x) and f(x + f(x)),
        ; in particular the denominator is f(x + f(x)) / f(x) - 1. Compute.
        F_XN = CALL_FUNCTION(F, XN)
        G_XN = CALL_FUNCTION(F, XN + F_XN) / F_XN - 1.0

        ; Like Newton's method, the new point is obtained by subtracting
        ; the ratio. g(x) = f(x + f(x)) / f(x) - 1 acts as the derivative
        ; of f, but we do not explicitly need to calculate f'(x).
        XN = XN - F_XN / G_XN

        ; If f(x) is very small, we are close to a root and can break out
        ; of this for loop. Check for this.
        IF (ABS(F_XN) LE EPSILON) THEN BREAK

    END

    ; Like Newton's method, and like Heron's method, the convergence is
    ; quadratic. After a few iterations we will be very to close a root.
    RETURN, XN

END

; sqrt(2) is the root of the function 2 - x^2. Define this.
FUNCTION FUNC, X

    COMPILE_OPT IDL2
    RETURN, 2.0 - X*X

END

; Program for testing our implementation of Steffensen's method.
PRO MAIN

    COMPILE_OPT IDL2

    ; The input for the method. We'll compute sqrt(2).
    X = DOUBLE(2.0)

    ; Run the routine, computing sqrt(x), and print the result.
    SQRT_2 = STEFFENSEN("FUNC", X)
    PRINT, X, SQRT_2, FORMAT = 'SQRT(%3.1f) = %18.16f'

END
