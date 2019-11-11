with ino; use ino;
with ada.text_io; use ada.text_io;
with ada.Float_Text_IO;

package calculations is
   
   polynomials : array (1 .. 3, 1 .. 4) of Float;
   eliminatedPoly: array(1 .. 3, 1 .. 4) of Float;
   Results : array(1 .. 3) of float;
   ScaledPoly : array (1 .. 3, 1 .. 4) of Float;
   
   --Name: Set Polynomials
   --Purpose: To receive a polynomial from the user and put it into an array
   --Author: Samuel McManus
   --Uses: getFloat in i/o file
   --Used By: N/A
   --Date: November 3 2019
   procedure setPolynomials;
   
   --Name: Read Polynomials
   --Purpose: To read polynomials out to the user
   --Author: Samuel McManus
   --Uses: N/A
   --Used By: N/A
   --Date: November 3 2019
   procedure readPolynomials;
   
   --Name: Scale Polynomials
   --Purpose: To find the scaled value of the column being eliminated in a 
   --         given polynomial
   --Author: Samuel McManus
   --@param Row: The row being scaled
   --@param EliminationColumn: The column being eliminated
   --@return: The scaled value of the column being eliminated
   --Uses: N/A
   --Used By: Find Largest Row
   --Date: November 3 2019
   function scalePolynomials(row : in integer; eliminationColumn : in integer) 
                             return float;
   
   --Name: Find Largest Row
   --Purpose: To find the row with the largest coefficient in the column
   --         being eliminated
   --Author: Samuel McManus
   --@param eliminationColumn: The column number being eliminated
   --Uses: Scale Polynomials
   --Used by: N/A
   --Date: November 3 2019
   procedure findLargestRow(eliminationColumn : in integer);
   
   
   --Name: RowEchelon
   --Purpose: To place our polynomials in row-echelon form
   --Author: Carl Gauss
   --@param EliminationColumn: stores the column being set to zero
   --@return: Tells whether the function is solvable using Gaussian elimination
   --Uses: N/A
   --Used by: N/A
   --Date: November 3 2019
   function RowEchelon(eliminationColumn : in integer) return integer;
   
   --Name: ReadResults
   --Purpose: To read the results for x, y, and z
   --Author: Samuel McManus
   --Uses: N/A
   --Used By: RowEchelon
   --Date: November 4 2019
   procedure readResults;
   
   --Name: BackSubstitute
   --Purpose: To use back-substitution to solve our function after placing it in
   --         row echelon form
   --Author: Carl Gauss
   --Uses: N/A
   --Used by: N/A
   --Date: November 4 2019
   procedure backSubstitute;
   

end calculations;
