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
;       Calculates roots using the bisection method.                           ;
;------------------------------------------------------------------------------;
;   Author: Ryan Maguire                                                       ;
;   Date:   2025/05/22                                                         ;
;------------------------------------------------------------------------------;
FUNCTION HERON, X

    ; Tells the compiler that integers should be 32 bits, not 16.
    COMPILE_OPT IDL2

    ; Error checking code.
    ON_ERROR, 2

    ; Heron's method is iterative. The convergence is quadratic, meaning the
    ; number of accurate decimals doubles with each iteration. Because of this
    ; we can halt the algorithm after a few steps.
    MAXIMUM_NUMBER_OF_ITERATIONS = 16

    ; Maximum allowed error. This is double precision epsilon.
    EPSILON = 2.220446049250313E-16

    ; Variable used for Heron's approximation. We will iteratively update
    ; this value with better approximations using Heron's method
    APPROXIMATE_ROOT = x

    ; Iteratively perform Heron's method.
    FOR ITERS = 1, MAXIMUM_NUMBER_OF_ITERATIONS DO BEGIN

        ; If the error is small we can break out of this loop.
        ERROR = (X - APPROXIMATE_ROOT * APPROXIMATE_ROOT) / X

        IF (ABS(ERROR) LE EPSILON) THEN BREAK

        ; Otherwise, improve our approximation using Heron's method.
        APPROXIMATE_ROOT = 0.5 * (APPROXIMATE_ROOT + X / APPROXIMATE_ROOT)

    END

    ; If x is positive and not too big, APPROXIMATE_ROOT should have a
    ; very accurate approximation to sqrt(x). Heron's method works for
    ; large inputs as well, but we need to increase the value of
    ; MAXIMUM_NUMBER_OF_ITERATIONS.
    RETURN, APPROXIMATE_ROOT

END

; Program for testing our implementation of Heron's method.
PRO MAIN

    COMPILE_OPT IDL2

    ; The input for the method. We'll compute sqrt(2).
    X = DOUBLE(2.0)

    ; Run the routine, computing sqrt(x), and print the result.
    SQRT_2 = HERON(X)
    PRINT, X, SQRT_2, FORMAT = 'SQRT(%3.1f) = %18.16f'

END

; We can run this by installing the GNU Data Language (GDL), which is
; a free and open source alternative to IDL:
;   https://gnudatalanguage.github.io/
; Once installed, start GDL by typing gdl. Once running, type:
;   GDL> .compile herons_method.pro
;   GDL> main
; This will produce the following output:
;   SQRT(2.0) = 1.4142135623730949
; The relative error is 1.570092458683775E-16.
