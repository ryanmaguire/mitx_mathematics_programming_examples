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
;   Date:   2025/03/09                                                         ;
;------------------------------------------------------------------------------;

;------------------------------------------------------------------------------;
;   Function:                                                                  ;
;       BISECTION_METHOD                                                       ;
;   Purpose:                                                                   ;
;       Computes roots using the bisection method.                             ;
;   Arguments:                                                                 ;
;       FUNC (FUNCTION):                                                       ;
;           A function from [A, B] to the real numbers.                        ;
;       A (REAL):                                                              ;
;           One of the endpoints for the interval.                             ;
;       B (REAL):                                                              ;
;           The other the endpoint for the interval.                           ;
;   OUTPUT:                                                                    ;
;       ROOT (REAL):                                                           ;
;           A root for FUNC.                                                   ;
;------------------------------------------------------------------------------;
FUNCTION BISECTION_METHOD, FUNC, A, B

    ; Tells the compiler that integers should be 32 bits, not 16.
    COMPILE_OPT IDL2

    ; Error checking code.
    ON_ERROR, 2

    ; Given a continuous function defined on [a, b], the nth iteration of the
    ; bisection method is at most |b - a| / 2^n away from the root. A double
    ; precision number has 52 bits in the mantissa, meaning if |b - a| ~= 1,
    ; then after 52 iterations we are as close to the root as we can get.
    ; To allow for a larger range, halt the algorithm after 64 iterations.
    MAXIMUM_NUMBER_OF_ITERATIONS = 64

    ; Maximum allowed error. This is double precision epsilon.
    EPSILON = 2.220446049250313E-16

    ; Initial setup, find out which evaluation is positive and which is
    ; negative. If the signs of the two agree we treat this as an error.
    A_EVAL = CALL_FUNCTION(FUNC, A)
    B_EVAL = CALL_FUNCTION(FUNC, B)

    ; Special case, A is a root. Set the output to A and return.
    IF (ABS(A_EVAL) LE EPSILON) THEN BEGIN
        RETURN, A
    ENDIF

    ; Similarly for B, if FUNC(B) ~= 0, return B.
    IF (ABS(B_EVAL) LE EPSILON) THEN BEGIN
        RETURN, B
    ENDIF

    ; If FUNC(A) < 0 < FUNC(B), then LEFT = A and RIGHT = B.
    IF (A_EVAL LT B_EVAL) THEN BEGIN

        ; If FUNC(A) and FUNC(B) have the same sign (both positive or
        ; both negative), return NaN. Bisection is undefined.
        IF ((A_EVAL GT 0) OR (B_EVAL LT 0)) THEN BEGIN
            RETURN, (A - A) / (A - A)
        ENDIF

        LEFT = A
        RIGHT = B

    ; If FUNC(B) < 0 < FUNC(A), then LEFT = B and RIGHT = A.
    ENDIF ELSE BEGIN

        ; Same sanity check as before, make sure the signs are different.
        IF ((A_EVAL LT 0) OR (B_EVAL GT 0)) THEN BEGIN
            RETURN, (A - A) / (A - A)
        ENDIF

        LEFT = B
        RIGHT = A
    ENDELSE

    MIDPOINT = 0.5 * (A + B)

    ; Iteratively perform the bisection method.
    FOR ITERS = 0, MAXIMUM_NUMBER_OF_ITERATIONS DO BEGIN

        ; The interval is cut in half based on the sign of FUNC(MIDPOINT).
        ; Compute this and compare.
        EVAL = CALL_FUNCTION(FUNC, MIDPOINT)

        ; If MIDPOINT is close to a root we can exit the function.
        IF (ABS(EVAL) LE EPSILON) THEN BEGIN
            BREAK
        ENDIF

        ; Otherwise, divide the range in half. If EVAL is negative we
        ; replace LEFT with MIDPOINT and move MIDPOINT closer to RIGHT.
        IF (EVAL LT 0) THEN BEGIN
            LEFT = MIDPOINT
            MIDPOINT = 0.5 * (MIDPOINT + RIGHT)

        ; Likewise, if EVAL is positive, replace RIGHT with MIDPOINT and
        ; move MIDPOINT closer to LEFT.
        ENDIF ELSE BEGIN
            RIGHT = MIDPOINT
            MIDPOINT = 0.5 * (LEFT + MIDPOINT)
        ENDELSE
    END

    ; Provided |B - A| is not too big, we should now have a very good
    ; approximation to the root.
    RETURN, MIDPOINT
END

; Program for testing our implementation of the bisection method.
PRO MAIN

    ; Tells the compiler that integers should be 32 bits, not 16.
    COMPILE_OPT IDL2

    ; Pi is somewhere between 3 and 4, use this interval.
    A = DOUBLE(3.0)
    B = DOUBLE(4.0)

    ; Run the routine, compute pi, and print the result.
    PI_BY_BISECTION = BISECTION_METHOD("SIN", A, B)
    PRINT, PI_BY_BISECTION, FORMAT = 'PI = %18.16f'

END
