FormFunction[{"l" -> "Number", "l1" -> "Number", "P3" -> "String", 
  "P4" -> "String"}, 
 DynamicModule[{l = #"l", l1 = #"l1", list1 = ToExpression[#"P3"], 
    list2 = ToExpression[#"P4"], r, length, list3, list4, list5, 
    list6, list7, list8, f, list9, list10}, length = Length@list1;
   r = Sqrt[Total /@ ((list1 - list2)^2)];
   list5 = 
    Normal@AssociationThread[{x3, y3, z3, x4, y4, z4, r1}, 
        Join[list1[[#]], list2[[#]], {r[[#]]}]] & /@ Range[length];
   list3 = ({r1^2 ((l + l1 - x3)^2 - ((l + l1 - x3)^2 + y3^2 + 
              z3^2) Cos[\[Theta]]^2), -2 r1 (l + l1 - x3) (x3 - x4) + 
         2 r1 ((l + l1 - x3) (x3 - x4) + y3 (-y3 + y4) + 
            z3 (-z3 + z4)) Cos[\[Theta]]^2, (x3 - 
            x4)^2 - ((x3 - x4)^2 + (y3 - y4)^2 + (z3 - 
               z4)^2) Cos[\[Theta]]^2} /. {\[Theta] -> 
         theta/180*Pi}) /. list5;
   list6 = 
    Normal[AssociationThread[{c, b, a} -> list3[[#]]]] & /@ 
     Range[length];
   list4 = {(-b - Sqrt[b^2 - 4 a c])/(2 a), (-b + 
         Sqrt[b^2 - 4 a c])/(2 a)} /. list6;
   list7 = 
    Normal[AssociationThread[{x1, x2}, list4[[#]]]] & /@ Range[length];
   list8 = ({{((r1 + x1) x3 - x1 x4)/r1, ((r1 + x1) y3 - x1 y4)/
           r1, ((r1 + x1) z3 - x1 z4)/
           r1}, {-(((b + a (-r1 + x1)) (x3 - x4))/(a r1)) + 
           x4, -(((b + a (-r1 + x1)) (y3 - y4))/(a r1)) + 
           y4, -(((b + a (-r1 + x1)) (z3 - z4))/(a r1)) + z4}} /. 
        Join[list5[[#]], list6[[#]], list7[[#]]] & /@ Range[length]); 
   f[theta1_] := {list4, list8} /. {theta -> theta1};
   TabView[{"点的坐标" -> 
      Manipulate[
       Dataset[<|"P2" -> (0 & /@ Range[3] & /@ Range[length])[[#]], 
           "P1" -> ({l, 0, 0} & /@ Range[length])[[#]], 
           "P12" -> ({l + l1, 0, 0} & /@ Range[length])[[#]], 
           "P23" -> (If[Re[f[theta][[1]][[#]][[1]]] > 0, 
                 f[theta][[2]][[#]][[1]], f[theta][[2]][[#]][[2]]] & /@
                Range[length])[[#]], "P3" -> list1[[#]], 
           "P4" -> list2[[#]]|> & /@ Range[length]], {theta, 0, 180}],
      "图形" -> 
      Manipulate[
       Grid[{#, (Show[
                Graphics3D /@ {{Thick, Red, 
                   Line[{{0, 0, 0}, {l, 0, 0}}]}, {Thick, Dashed, 
                   Blue, Line[{{l, 0, 0}, {l + l1, 0, 0}}]}, {Thick, 
                   Dashed, 
                   Line[{{l + l1, 0, 
                    0}, (If[Re[f[theta][[1]][[#]][[1]]] > 0, 
                    Re@f[theta][[2]][[#]][[1]], 
                    Re@f[theta][[2]][[#]][[2]]] & /@ 
                    Range[length])[[#]]}]}, {Thick, Dashed, Blue, 
                   Line[{(If[Re[f[theta][[1]][[#]][[1]]] > 0, 
                    Re@f[theta][[2]][[#]][[1]], 
                    Re@f[theta][[2]][[#]][[2]]] & /@ 
                    Range[length])[[#]], list1[[#]]}]}, {Thick, Red, 
                   Line[{list1[[#]], list2[[#]]}]}}] & /@ 
              Range[length])[[#]], (Show[
                Graphics3D /@ 
                 Table[{{Thick, Red, 
                    Line[{{0, 0, 0}, {l, 0, 0}}]}, {Thick, Dashed, 
                    Blue, Line[{{l, 0, 0}, {l + l1, 0, 0}}]}, {Thick, 
                    Dashed, 
                    Line[{{l + l1, 0, 
                    0}, (If[Re[f[theta1][[1]][[#]][[1]]] > 0, 
                    Re@f[theta1][[2]][[#]][[1]], 
                    Re@f[theta1][[2]][[#]][[2]]] & /@ 
                    Range[length])[[#]]}]}, {Thick, Dashed, Blue, 
                    Line[{(If[Re[f[theta][[1]][[#]][[1]]] > 0, 
                    Re@f[theta1][[2]][[#]][[1]], 
                    Re@f[theta1][[2]][[#]][[2]]] & /@ 
                    Range[length])[[#]], list1[[#]]}]}, {Thick, Red, 
                    Line[{list1[[#]], list2[[#]]}]}}, {theta1, 0, 
                   theta, 2}]] & /@ Range[length])[[#]]} & /@ 
         Range[length], Frame -> All], {theta, 0, 180}], 
     "角度" -> Manipulate[
       Dataset@AssociationThread[Range[length], 
         180/Pi*VectorAngle[{l, 0, 
              0}, (If[Re[f[theta][[1]][[#]][[1]]] > 0, 
                   Re@f[theta][[2]][[#]][[1]], 
                   Re@f[theta][[2]][[#]][[2]]] & /@ 
                 Range[length])[[#]] - {l + l1, 0, 0}] & /@ 
          Range[length]], {theta, 0, 180}]}]] &]