include "alldifferent.mzn";

include "../common/letters.mzn";
include "../common/words.mzn";
include "../common/base.mzn";

ann: searchLetter1 = int_search(array1d(ls), first_fail, indomain_split, complete);
ann: searchLetter2 = int_search(array1d(ls), first_fail, indomain_min, complete);

ann: searchWord1 = int_search(ws, first_fail, indomain_split, complete);
ann: searchWord2 = int_search(ws, first_fail, indomain_min, complete);

ann: search = searchLetter1;

solve 
    :: search
    maximize objective;

%------------------------------------------------------------------------------%
% Output item

output [ 
    if col = 1 then "% " else "" endif 
++  if grid[row, col] then show(ls[row, col]) else "#" endif 
++  if col = width then "\n" else "" endif
| row in ROWS, col in COLS
] ++ [ 
    "ww = \(ws);\n",
    "objective = \(objective);\n",
] ;
