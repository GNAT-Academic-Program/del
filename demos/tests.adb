with Ada.Assertions;  use Ada.Assertions;
with Ada.Exceptions;   use Ada.Exceptions;

with Ada.Characters.Latin_1; use Ada.Characters.Latin_1;
with Ada.Text_IO; use Ada.Text_IO;

procedure Tests is
   pragma Assertion_Policy (Assert => Ignore);

   type Color_T is record
        R, G, B : Integer;
   end record;

   Red  : constant Color_T := (255, 0, 0);
   Green : constant Color_T := (0, 255, 0);

   function Text_Color  return String is (ESC & "[38;2");
   function Terminator  return String is ("m"); 
   function Reset       return String is (ESC & "[0m");

   function C_To_S (C : Color_T) return String is
      R : String := C.R'Image;
      G : String := C.G'Image;
      B : String := C.B'Image;
   begin
      return ";" & R (2 .. R'Length) & 
             ";" & G (2 .. G'Length) & 
             ";" & B (2 .. B'Length);
   end;
            
   function String_In_Color (S : String; C : Color_T) return String is
      (Text_Color & C_To_S (C) & Terminator & S & Reset);

   Tests_Passed : Integer := 0;
   Tests_Failed : Integer := 0;

   procedure Fail_Msg (Test_Nbr : Integer; Msg : String) is
      Str : constant String := Test_Nbr'Image;
   begin
      Tests_Failed := @ + 1;
      Put_Line ("Assertion failed in Test_" & Str (2 .. Str'Length) & " " & String_In_Color (Msg, Red));
   end;
   
   procedure Test_1 is
      First : Integer := 1;
      Second : Integer := 2;
   begin     
      assert (First = Second, "First is not equal to Second");
      Tests_Passed := @ + 1;
   exception
      when E : Assertion_Error =>
         Fail_Msg (1, Exception_Message(E));
   end;

   procedure Test_2 is
      First : Integer := 1;
      Second : Integer := 1;
   begin     
      assert (First = Second, "First is not equal to Second");
      Tests_Passed := @ + 1;
   exception
      when E : Assertion_Error =>
         Fail_Msg (2, Exception_Message(E));
   end;

begin
   Test_1;
   Test_2;
   Put ("Done: " & 
             String_In_Color (Tests_Passed'Image & " PASSED, ", Green) & 
             String_In_Color (Tests_Failed'Image & " FAILED.", Red));
   New_Line;
end Tests;