with ada.text_io; use ada.text_io;
with ada.Exceptions; use ada.Exceptions;

package body InO is

   function getInt(userMessage : in String) return integer is
   begin
      loop
         put_line(userMessage);
         declare
            integerValOfTerm : integer;
            termInFunction : String := Get_Line;
         begin
            integerValOfTerm := integer'value(termInFunction);
            return integerValOfTerm;
         exception
            when E : Constraint_Error =>
               put_line("You have entered an invalid value");
         end;
         end loop;

   end getInt;
   
   function getFloat(userMessage : in String) return float is
   begin
      loop
         put_line(userMessage);
         declare
            floatValOfTerm : float;
            termInFunction : String := get_line;
         begin
            floatValOfTerm := float'value(termInFunction);
            return floatValOfTerm;
         exception
            when E : Constraint_Error =>
               put_line("You have entered an invalid value");
         end;
      end loop;
   end getFloat;
   
      
   
end InO;
