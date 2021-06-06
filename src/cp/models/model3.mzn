include "alldifferent.mzn";

include "../common/letters.mzn";
include "../common/words.mzn";
include "../common/base.mzn";
include "../common/predicates.mzn";
include "../common/constraints.mzn";

ann: search = int_search(ws, first_fail, indomain_split, complete);

solve 
    :: search
    maximize objective;

%------------------------------------------------------------------------------%
% Output item

output [ 
    if col = 1 then "% " else "" endif 
++  if grid[row, col] then show(ls[row, col]) else "*" endif 
++  if col = width then "\n" else "" endif
| row in ROWS, col in COLS
] ++ [ 
    "Words weights = \(ws);\n",
    "objective = \(objective);\n",
] ;
