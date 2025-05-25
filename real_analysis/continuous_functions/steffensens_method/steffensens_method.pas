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
 *      Computes roots using Steffensen's method.                             *
 ******************************************************************************
 *  Author: Ryan Maguire                                                      *
 *  Date:   2025/05/25                                                        *
 ******************************************************************************)
PROGRAM Steffensen;

(*  We define two constants: The allowed tolerance (or epsilon value),        *
 *  and the maximum number of iterations we allow for Steffensen's method.    *)
CONST

    (*  Steffensen's method is iterative and converges very quickly.          *
     *  Because of this we may exit the function after a few iterations.      *)
    MaximumNumberOfIterations: Integer = 16;

    (*  The maximum allowed error. This is 4x double precision epsilon.       *)
    Epsilon: Real = 8.881784197001252E-16;

    (*  2 is close enough to sqrt(2) for Steffensen's method to work.         *)
    Guess: Real = 2.0;

(*  Create an alias for real functions f: R -> R. This makes the syntax of    *
 *  the parameters for SteffensensMethod function a little more readable.     *)
TYPE
    RealFunc = Function(Const X: Real): Real;

(*  The program has one variable, sqrt(2) computed via Steffensen's method.   *)
VAR
    Sqrt2: Real;

(*  f(x) = 2 - x^2 has sqrt(2) as a root. This is the input function.         *)
Function Func(const X: Real) : Real;
BEGIN
    Func := 2.0 - X*X;
END;

(******************************************************************************
 *  Function:                                                                 *
 *      SteffensensMethod                                                     *
 *  Purpose:                                                                  *
 *      Computes roots using Steffensen's method.                             *
 *   Arguments:                                                               *
 *      F (RealFunc):                                                         *
 *          A continuous function f: R -> R.                                  *
 *      X (Real):                                                             *
 *          The initial guess point for Steffensen's method.                  *
 *   OUTPUT:                                                                  *
 *       Root (Real):                                                         *
 *           A root for F near X.                                             *
 ******************************************************************************)
Function SteffensensMethod(Const F: RealFunc; Const X: Real) : Real;

VAR
    (*  Steffensen's method is iterative, like Newton's method, but avoids    *
     *  explicit use of the derivative of F. Instead it uses the function     *
     *  G(x) = F(x + F(x)) / F(X) - 1, which acts like F'(x). Provide a       *
     *  variable for each of these expressions, Xn is the nth approximation.  *)
    Xn, Fxn, Gxn: Real;

    (*  Dummy variable for tracking how many iterations we've performed.      *)
    Iters: Integer;

BEGIN

    (*  Steffensen's method starts the iterative process at the guess point.  *)
    Xn := X;

    (*  Iteratively perform Steffensen's method.                              *)
    FOR Iters := 0 TO MaximumNumberOfIterations - 1 DO
    BEGIN

        (*  Steffensen's method needs the evaluations f(x) and f(x + f(x)),   *
         *  in particular the denominator is f(x + f(x)) / f(x) - 1. Compute. *)
        Fxn := F(Xn);
        Gxn := F(Xn + Fxn) / Fxn - 1.0;

        (*  Like Newton's method, the new point is obtained by subtracting    *
         *  the ratio. g(x) = f(x + f(x)) / f(x) - 1 acts as the derivative   *
         *  of f, but we do not explicitly need to calculate f'(x).           *)
        Xn := Xn - Fxn / Gxn;

        (*  If f(x) is very small, we are close to a root and can break out   *
         *  of this for loop. Check for this.                                 *)
        IF (ABS(Fxn) < Epsilon) THEN BREAK;

    END;

    (*  Like Newton's method, and like Heron's method, the convergence is     *
     *  quadratic. After a few iterations we will be very to close a root.    *)
    SteffensensMethod := Xn;
END;

(*  Program for testing our implementation of Steffensen's method.            *)
BEGIN

    (*  Compute sqrt(2) using Steffensen's method and print the result.       *)
    Sqrt2 := SteffensensMethod(@Func, Guess);
    WriteLn('sqrt(2) = ', Sqrt2:0:16);

END.
