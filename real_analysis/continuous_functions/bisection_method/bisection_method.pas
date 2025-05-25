(******************************************************************************
 *                                  LICENSE                                   *
 ******************************************************************************
 *  This file is part of mitx_mathematics_programming_examples.               *
 *                                                                            *
 *  mitx_mathematics_programming_examples is free software: you can           *
 *  redistribute it and/or modify it under the terms of the GNU General Public*
 *  License as published by the Free Software Foundation, either version 3 of *
 *  the License, or (at your option) any later version.                       *
 *                                                                            *
 *  mitx_mathematics_programming_examples is distributed in the hope that it  *
 *  will be useful but WITHOUT ANY WARRANTY; without even the implied warranty*
 *  of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          *
 *  GNU General Public License for more details.                              *
 *                                                                            *
 *  You should have received a copy of the GNU General Public License         *
 *  along with mitx_mathematics_programming_examples.  If not, see            *
 *  <https://www.gnu.org/licenses/>.                                          *
 ******************************************************************************
 *  Purpose:                                                                  *
 *      Computes roots using the bisection method.                            *
 ******************************************************************************
 *  Author: Ryan Maguire                                                      *
 *  Date:   2025/04/17                                                        *
 ******************************************************************************)
PROGRAM Bisection;

(*  We define two constants: The allowed tolerance (or epsilon value),        *
 *  and the maximum number of iterations we allow for the bisection method.   *)
CONST

    (*  Tell the algorithm to stop after several iterations to avoid an       *
     *  infinite loop. Double precision numbers have 52 bits in the mantissa, *
     *  so if |b - a| ~= 1, after 52 iterations of bisection we will get as   *
     *  close as we can to the root. To allow for |b - a| to be larger, halt  *
     *  the algorithm after at most 64 steps.                                 *)
    MaximumNumberOfIterations: Integer = 64;

    (*  Maximum allowed error. This is double precision epsilon.              *)
    Epsilon: Real = 2.220446049250313E-16;

    (*  Pi is between 2 and 4 and is a root to sine.                          *)
    LeftValue: Real = 2.0;
    RightValue: Real = 4.0;

(*  Create an alias for real functions f: R -> R. This makes the syntax of    *
 *  the parameters for the BisectionMethod function a little more readable.   *)
TYPE
    RealFunc = Function(Const X: Real): Real;

(*  The main program only has one variable, pi computed via bisection.        *)
VAR
    PiByBisection: Real;

(*  Sin is a built-in procedure. Create a function Real -> Real that computes *
 *  sin(x) so that we may pass it as a parameter to BisectionMethod.          *)
Function Sine(const X: Real) : Real;
BEGIN
    Sine := SIN(X);
END;

(******************************************************************************
 *  Function:                                                                 *
 *      BisectionMethod                                                       *
 *  Purpose:                                                                  *
 *      Computes roots using the bisection method.                            *
 *   Arguments:                                                               *
 *       F (RealFunc):                                                        *
 *           A function from [A, B] to the real numbers.                      *
 *       A (Real):                                                            *
 *           One of the endpoints for the interval.                           *
 *       B (Real):                                                            *
 *           The other the endpoint for the interval.                         *
 *   OUTPUT:                                                                  *
 *       Root (Real):                                                         *
 *           A root for F between A and B.                                    *
 ******************************************************************************)
Function BisectionMethod(Const F: RealFunc; Const A, B: Real) : Real;

VAR
    (*  We do not require A < B, nor F(A) < F(B). We will use Left and Right  *
     *  to re-orient the interval so that F(Left) < F(Right). Midpoint will   *
     *  be the center of the interval, and these three values will be updated *
     *  iteratively as we perform the bisection method.                       *)
    Left, Right, Midpoint: Real;

    (*  Variables for the evaluation of F at A, B, and Midpoint, respectively.*)
    AEval, BEval, Eval: Real;

    (*  Dummy variable for tracking how many iterations we've performed.      *)
    Iters: Integer;

LABEL
    (*  Several spots allow for early returns in the function. We use a       *
     *  single label for GOTO to allow us to break out of the function.       *)
    Finished;

BEGIN

    (*  Initial setup, find out which evaluation is positive and which is     *
     *  negative. If the signs of the two agree we treat this as an error.    *)
    AEval := F(A);
    BEval := F(B);

    (*  Special case, A is a root. Set the output to A and return.            *)
    IF (ABS(AEval) < Epsilon) THEN
    BEGIN
        BisectionMethod := A;
        GOTO Finished;
    END;

    (*  Similarly for B, if F(B) ~= 0, return B.                              *)
    IF (ABS(BEval) < Epsilon) THEN
    BEGIN
        BisectionMethod := B;
        GOTO Finished;
    END;

    (*  If F(A) < 0 < F(B), then Left = A and Right = B.                      *)
    IF (AEval < BEval) THEN
    BEGIN

        (*  If F(A) and F(B) have the same sign (both positive or
         *  both negative), return NaN. Bisection is undefined.               *)
        IF ((AEval > 0) OR (BEval < 0)) THEN
        BEGIN
            BisectionMethod := (A - A) / (A - A);
            GOTO Finished;
        END;

        Left := A;
        Right := B;

    (*  If F(B) < 0 < F(A), then Left = B and Right = A.                      *)
    END
    ELSE
    BEGIN

        (*  Same sanity check as before, make sure the signs are different.   *)
        IF ((AEval < 0) OR (BEval > 0)) THEN
        BEGIN
            BisectionMethod := (A - A) / (A - A);
            GOTO Finished;
        END;

        Left := B;
        Right := A;
    END;

    Midpoint := 0.5 * (A + B);

    (*  Iteratively perform the bisection method.                             *)
    FOR Iters := 0 TO MaximumNumberOfIterations - 1 DO
    BEGIN

        (*  The interval is cut in half based on the sign of F(Midpoint).     *
         *  Compute this and compare.                                         *)
        Eval := F(Midpoint);

        (*  If MIDPOINT is close to a root we can exit the function.          *)
        IF (ABS(Eval) < Epsilon) THEN BREAK;

        (*  Otherwise, divide the range in half. If Eval is negative we       *
         *  replace Left with Midpoint and move Midpoint closer to Right.     *)
        IF (Eval < 0) THEN BEGIN
            Left := Midpoint;
            Midpoint := 0.5 * (Midpoint + Right);

        (*  Likewise, if Eval is positive, replace Right with Midpoint and    *
         *  move Midpoint closer to Left.                                     *)
        END ELSE BEGIN
            Right := Midpoint;
            Midpoint := 0.5 * (Left + Midpoint);
        END;
    END;

    (*  Provided |B - A| is not too big, we should now have a very good       *
     *  approximation to the root.                                            *)
    BisectionMethod := Midpoint;

    Finished:
END;

(*  Program for testing our implementation of the bisection method.           *)
BEGIN

    (*  Pi is between 2 and 4 and is a root to sine.                          *)
    PiByBisection := BisectionMethod(@Sine, LeftValue, RightValue);
    WriteLn('pi = ', PiByBisection:0:16);

END.
