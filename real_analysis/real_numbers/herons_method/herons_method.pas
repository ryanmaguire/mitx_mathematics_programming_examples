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
 *      Calculates square roots using Heron's method.                         *
 ******************************************************************************
 *  Author: Ryan Maguire                                                      *
 *  Date:   2025/03/09                                                        *
 ******************************************************************************)
PROGRAM Heron;

(*  We define two constants: The allowed tolerance (or epsilon value),        *
 *  and the maximum number of iterations we allow for Heron's method.         *)
CONST

    (*  Heron's method is iterative. The convergence is quadratic,            *
     *  meaning the number of accurate decimals doubles with each             *
     *  iteration. Because of this we can stop after a few steps.             *)
    MaximumNumberOfIterations: Integer = 16;

    (*  Maximum allowed error. This is double precision epsilon.              *)
    Epsilon: Real = 2.220446049250313E-16;

    (*  The input value we will compute the square root of.                   *)
    Value: Real = 2.0;

VAR
    (*  Variable for the square root of our input.                            *)
    SqrtValue: Real;

(******************************************************************************
 *  Function:                                                                 *
 *      HeronsMethod                                                          *
 *  Purpose:                                                                  *
 *      Computes square roots using Heron's method.                           *
 *  Arguments:                                                                *
 *      X (Real):                                                             *
 *          A positive real number.                                           *
 *  OUTPUT:                                                                   *
 *      SqrtX (Real):                                                         *
 *          The square root of X.                                             *
 ******************************************************************************)
Function HeronsMethod(Const X: Real) : Real;

VAR
    Error: Real;
    Iters: Integer;

BEGIN

    (* Heron's method needs a starting value. Pick the input.                 *)
    HeronsMethod := X;

    (*  Iteratively perform Heron's method.                                   *)
    FOR Iters := 0 TO MaximumNumberOfIterations - 1 DO
    BEGIN

        (*  If the error is small we can break out of this loop.              *)
        Error := (X - HeronsMethod * HeronsMethod) / X;

        IF (ABS(Error) < Epsilon) THEN BREAK;

        (*  Otherwise, improve our approximation using Heron's method.        *)
        HeronsMethod := 0.5 * (HeronsMethod + X / HeronsMethod);
    END;
END;

(*  Program for testing our implementation of Heron's method.                 *)
BEGIN

    (*  Compute the square root using Heron's method and print the result.    *)
    SqrtValue := HeronsMethod(Value);
    WriteLn('sqrt(', Value:0:1, ') = ', SqrtValue:0:16);

END.

(*  We can compile this using the Free Pascal Compiler (fpc):                 *
 *      https://www.freepascal.org/                                           *
 *  Once installed, on GNU, Linux, FreeBSD, macOS, etc., this can be run by:  *
 *      fpc herons_method.pas -omain                                          *
 *      ./main                                                                *
 *  This outputs:                                                             *
 *      sqrt(2.0) = 1.4142135623730949                                        *
 *  The relative error is 1.570092458683775E-16.                              *
 *                                                                            *
 *  On Windows, type:                                                         *
 *      fpc herons_method.pas -omain.exe                                      *
 *      main.exe                                                              *
 *  This produces the same output.                                            *)
