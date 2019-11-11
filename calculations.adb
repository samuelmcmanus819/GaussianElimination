--See specification file and main for documentation


package body Calculations is
   
   
   
   procedure setPolynomials is
      termInFunction : float;
   begin
      for i in 1 ..polynomials'last loop
         for j in 1 .. polynomials'last + 1 loop
            
            termInFunction := ino.getFloat("Enter term #" & integer'image(j) 
                                         & " of polynomial #" & integer'image(i)); 
            polynomials(i, j) := termInFunction;
         
         end loop;
      end loop;    
   end setPolynomials;
   
   
   
   
   
   procedure readPolynomials is
   begin
      for i in 1 .. polynomials'last loop
      
         put_line("Polynomial number " & integer'image(i));
         
         for j in 1 .. polynomials'last + 1 loop
            
            put(float'image(polynomials(i,j)));
            
            case j is 
               
               when 1 => put("x + ");
               when 2 => put("y + ");
               when 3 => put("z = ");
               when others => null;
                  
            end case;      
                  
         end loop;
         new_line(2);
      end loop;
   end readPolynomials;
   
   
   
   
   

   
   --Finds the largest value in the polynomials array
   --Only compares to columns whose index is greater than the one that's 
   --Being eliminated, because those are the only ones who are going to be
   --subtracted, and thus the only ones which could lead to error.
   
   function scalePolynomials(row : in integer; eliminationColumn : in integer) return float is
      
      largestFloat : float := float'last;
      
   begin
      
      for i in eliminationColumn .. polynomials'last loop
         if (polynomials(row, i) > largestFloat)
         then
            largestFloat := polynomials(row, i);
         end if;
      end loop;
      
         
      
      return (polynomials(row, eliminationColumn) / largestFloat);
      
      
   end scalePolynomials;
   
   
   
   
   
   procedure findLargestRow(eliminationColumn : in integer) is
      largestScaledValue : float := float'first;
      rowOfLargestScaledValue : integer := eliminationColumn;
      
   begin
      
      --Scans all of the rows from eliminationColumn (which coincidentally
      --is both the column being eliminated and the first row we care about)
      --to row three to determine which one has the largest value in the
      --column being eliminated
      for i in eliminationColumn .. polynomials'last loop
         
         
         if (abs(scalePolynomials(i, eliminationColumn)) > largestScaledValue)
         then
            
            largestScaledValue := scalePolynomials(i, eliminationColumn);
            rowOfLargestScaledValue := i;
            
         end if;
      end loop;
           
      if not (rowOfLargestScaledValue = 1)
      then
         for i in 1 .. polynomials'last + 1 loop
            
            scaledPoly(1, i) := polynomials(eliminationColumn, i);
            polynomials(eliminationColumn, i) := polynomials(rowOfLargestScaledValue, i);
            polynomials(rowOfLargestScaledValue, i) := scaledPoly(1, i);
            
         end loop;
         
      end if;
      
         
   end findLargestRow;
      
               
   
      
   function RowEchelon(eliminationColumn : in integer) return integer is
      multiplicand : float;
   begin
      
           --Checks if the row/column we're eliminating with has a value of zero
      --if so, we swap it with the next row.
      if (polynomials(eliminationColumn, eliminationColumn) = 0.0)
      then
         for k in eliminationColumn + 1 .. polynomials'last loop
            if not (polynomials(k, eliminationColumn) = 0.0)
            then
               for l in 1 .. polynomials'last + 1 loop
                     
                  scaledpoly(1,l) := polynomials(eliminationColumn, l);
                  polynomials(eliminationColumn, l) := polynomials(k, l);
                  polynomials(k,l) := scaledPoly(1,l);
                  
               end loop;
               exit;
            end if;
         end loop;
      end if;
      
      --Sends data from the already-finished columns to eliminatedPoly
      for i in 1 .. eliminationColumn  loop
         for j in 1 .. polynomials'last + 1 loop
            
            eliminatedPoly(i,j) := polynomials(i,j);
            
         end loop;
      end loop;
      
     
      
      
      --If, at the end of the day, all of our polynomials have a coefficient of
      --zero in the elimination column, then our function will fail. 
      --Otherwise, perform elimination
      if not(polynomials(eliminationColumn, eliminationColumn) = 0.0)
      then
         
      
         --Sets the multiplicand equal to the row/column being eliminated
         --divided by the row/column used to perform elimination
         for i in eliminationColumn + 1 .. polynomials'last loop
             
        
            multiplicand := polynomials(i, eliminationColumn) / 
              polynomials(eliminationColumn,eliminationColumn);
         
            --Sets eliminated poly values for each space being eliminated to 
            --its original value minus the eliminating column * the multiplicand
            for j in eliminationColumn .. polynomials'last + 1 loop
            
               eliminatedPoly(i,j) := polynomials(i,j) - (multiplicand * 
                                                            polynomials(eliminationColumn,j));
         
            end loop;
         end loop;
      
         --Stores the values from eliminated polynomial to the standard polynomial
         for i in 1 .. polynomials'last loop
            for j in 1 .. polynomials'last + 1 loop
            
               polynomials(i,j) := eliminatedPoly(i,j);
            
            end loop;
         end loop;
         return 1;
         
      else
         return 0;
      end if;
      
         
      
   end RowEchelon;
   
   
   
   procedure readResults is
   begin
      for i in 1 .. results'length loop
         
         case i is
            when 1 => put("x = ");
            when 2 => put("y = ");
            when 3 => put("z = ");
         end case;
         
         ada.Float_Text_IO.Put(results(i), aft => 20);
         new_line;
         
      end loop;
   end readResults;
   
   
   
   procedure backSubstitute is
      tempResult : float := 0.0;
      
   begin
      
      --sets the values for x, y, and z in reverse order
      for i in reverse 1 .. polynomials'last loop
            
         --Temporary result is set to the result of function i
         tempResult := polynomials(i, 4);
         --For every row we have already cancelled out, substitute its value
         for j in reverse i + 1 .. polynomials'last loop
            tempResult := tempResult - (polynomials(i, j) * results(j));
         end loop;

         --Pipe the results to the appropriate result array space
         results(i) := tempresult / polynomials(i, i);
         
      end loop;
      
   end backSubstitute;
   
         
             
            
   
   
   
   
end Calculations;
