with calculations; use calculations;
with ada.text_io; use ada.text_io;
with ino; use ino;



--Name: Gaussian Elimination
--Purpose: To solve functions using Gaussian Elimination and back substitution
--         and compare results to Gaussian elimination using partial pivot
--Author: Samuel McManus
--Date: November 3, 2019

--Error-Checking: Checks to see whether the function is solvable using gaussian
--                elimination. Checks whether function needs to swap rows in 
--                order to solve.

procedure GaussianElimination is

begin
   declare      
      option : integer;
      viable : integer;
      
   begin
      
      calculations.setPolynomials;
      calculations.readPolynomials;
      
      loop
         option := ino.getInt("Press 1 to do a standard Gaussian elimination" &
                             ", or press 2 to use a partial pivot");
      
         case option is
            
            when 1=> 
               
               for i in 1 .. 2 loop
         
                  viable := calculations.RowEchelon(i);
                  if (viable = 0)
                  then
                     exit;
                  end if;
         
               end loop;
               exit;
               
               when 2 => 
               
               for i in 1 .. 2 loop
                  
                  calculations.findLargestRow(i);
                  viable := calculations.RowEchelon(i);
                  if (viable = 0)
                  then
                     exit;
                  end if;
                  
               end loop;
               exit;
                  
                  when others => null;
               
         end case;
         
      end loop;
      
      if (viable = 0) 
      then
         put_line("Your functions were not viable for row echelon form :(");
      else
         calculations.readPolynomials;
         calculations.backSubstitute;
         calculations.readResults;
      end if;
      
   end;
end GaussianElimination;
