
with Del; 
with Del.Operators;
with Del.Initializers;
with Ada.Text_IO; use Ada.Text_IO;
with Orka.Numerics.Singles.Tensors.CPU; use Orka.Numerics.Singles.Tensors.CPU;

procedure Main is

   package D renames Del;
   package DI renames Del.Initializers;
   package DOp renames Del.Operators;

   --  L : D.Func_Access_T := new DOp.Linear_T;
   --  R : D.Func_Access_T := new DOp.ReLU_T;

   Fs : D.Funcs_T := (new DOp.Linear_T, new DOp.ReLU_T);

begin
   for I in Fs'Range loop
      declare
         T : D.Tensor_T := Fs(I).all.Forward (Zeros((2, 2)));
      begin
         null;
      end;
   end loop;
end Main;
