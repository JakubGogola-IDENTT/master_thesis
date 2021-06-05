include "alldifferent.mzn";

include "../common/letters.mzn";
include "../common/words.mzn";

int: width;     % Width of the grid
int: height;    % Height of the grid

set of int: ROW = 1..height;    % Set of rows
set of int: COL = 1..width;     % Set of columns

array[ROW,COL] of bool: grid;   % false - "black" cell (no letters)

int: max_words = max([
    words2,words3,words4,words5,words6,words7,words8,words9,
    words10,words11,words12,words13,words14,words15,words16,words17,words18,words19,
    words20,words21,words22,words23,words24,words25,words26,words27,words28,words29,
    words30,words31,words32,words33,words34,words35,words36,words37,words38,words39,
    words40,words41,words42,words43,words44,words45
]);
set of int: WORD = 1..max_words;             
 

int: number_of_clues;
set of int: CLUE = 1..number_of_clues;
% set of string: XDDDD = 'a'..'z';

array[CLUE] of ROW: startrow;
array[CLUE] of COL: startcol;
array[CLUE] of bool: down;
array[CLUE] of int: leng;

%------------------------------------------------------------------------------%
% Variables

array[ROW,COL] of var LETTER: xx;   % Variables for the letter for each cell
array[CLUE] of var WORD: ww;        % Variables for the word for each clue
var min(value) * (height*width) .. max(value) * (height * width): objective;

%------------------------------------------------------------------------------%
% Includes

include "alldifferent.mzn";

%------------------------------------------------------------------------------%
% Predicates

predicate table_row(array [int] of var int: x, array [int,int] of int: t, var int: row) =
    forall(i in index_set(x))(
        x[i] = t[row, i]
    );
                 
%------------------------------------------------------------------------------%
% Constraints

    % Objective
    %
constraint objective = sum(r in ROW, c in COL)( value[ xx[r,c] ] );

    % A word only can appear once
    %
constraint forall(l in 2..22)(
    alldifferent(c in CLUE where leng[c] = l)(ww[c])
);

    % Pre-assign "black" cells with the letter 'a'
    %
constraint forall(r in ROW, c in COL)(
    not grid[r,c] -> xx[r,c] = a
);

    % Word constraints
    %
constraint forall(clue in CLUE)(
    let { 
        int: r = startrow[clue]; 
        int: c = startcol[clue]; 
    } in (
        if down[clue] then
           %% vertical word starting at (r,c)
           let {int: len = leng[clue]; 
                array[int] of var LETTER: clueword = [ xx[i,c] | i in r..r+len-1 ];
               } in
           if len = 1 then table_row(clueword, dict1, ww[clue])
           elseif len =  2 then table_row(clueword, dict2, ww[clue])
           elseif len =  3 then table_row(clueword, dict3, ww[clue])
           elseif len =  4 then table_row(clueword, dict4, ww[clue])
           elseif len =  5 then table_row(clueword, dict5, ww[clue])
           elseif len =  6 then table_row(clueword, dict6, ww[clue])
           elseif len =  7 then table_row(clueword, dict7, ww[clue])
           elseif len =  8 then table_row(clueword, dict8, ww[clue])
           elseif len =  9 then table_row(clueword, dict9, ww[clue])
           elseif len = 10 then table_row(clueword, dict10, ww[clue])
           elseif len = 11 then table_row(clueword, dict11, ww[clue])
           elseif len = 12 then table_row(clueword, dict12, ww[clue])
           elseif len = 13 then table_row(clueword, dict13, ww[clue])
           elseif len = 14 then table_row(clueword, dict14, ww[clue])
           elseif len = 15 then table_row(clueword, dict15, ww[clue])
           elseif len = 16 then table_row(clueword, dict16, ww[clue])
           elseif len = 17 then table_row(clueword, dict17, ww[clue])
           elseif len = 18 then table_row(clueword, dict18, ww[clue])
           elseif len = 19 then table_row(clueword, dict19, ww[clue])
           elseif len = 20 then table_row(clueword, dict20, ww[clue])
           elseif len = 21 then table_row(clueword, dict21, ww[clue])
           elseif len = 22 then table_row(clueword, dict22, ww[clue])
           else 
              assert(len > 22, "word length too long \(len) > 22\n")
           endif
        else 
           %% horizontal word starting at (r,c)
           let {int: len = leng[clue]; 
                array[int] of var LETTER: clueword = [ xx[r,i] | i in c..c+len-1 ];
                } in 
           if len = 1 then table_row(clueword, dict1, ww[clue])
           elseif len = 2 then table_row(clueword, dict2, ww[clue])
           elseif len = 3 then table_row(clueword, dict3, ww[clue])
           elseif len = 4 then table_row(clueword, dict4, ww[clue])
           elseif len = 5 then table_row(clueword, dict5, ww[clue])
           elseif len = 6 then table_row(clueword, dict6, ww[clue])
           elseif len = 7 then table_row(clueword, dict7, ww[clue])
           elseif len = 8 then table_row(clueword, dict8, ww[clue])
           elseif len = 9 then table_row(clueword, dict9, ww[clue])
           elseif len = 10 then table_row(clueword, dict10, ww[clue])
           elseif len = 11 then table_row(clueword, dict11, ww[clue])
           elseif len = 12 then table_row(clueword, dict12, ww[clue])
           elseif len = 13 then table_row(clueword, dict13, ww[clue])
           elseif len = 14 then table_row(clueword, dict14, ww[clue])
           elseif len = 15 then table_row(clueword, dict15, ww[clue])
           elseif len = 16 then table_row(clueword, dict16, ww[clue])
           elseif len = 17 then table_row(clueword, dict17, ww[clue])
           elseif len = 18 then table_row(clueword, dict18, ww[clue])
           elseif len = 19 then table_row(clueword, dict19, ww[clue])
           elseif len = 20 then table_row(clueword, dict20, ww[clue])
           elseif len = 21 then table_row(clueword, dict21, ww[clue])
           elseif len = 22 then table_row(clueword, dict22, ww[clue])
           else
              assert(len > 22, "word length too long \(len) > 22\n")
           endif
        endif
    )
);     

%------------------------------------------------------------------------------%
% Search and solve item

ann: searchLetter1 = int_search(array1d(xx), first_fail, indomain_split, complete);
ann: searchLetter2 = int_search(array1d(xx), first_fail, indomain_min, complete);

ann: searchWord1 = int_search(ww, first_fail, indomain_split, complete);
ann: searchWord2 = int_search(ww, first_fail, indomain_min, complete);

ann: search = searchLetter1;

solve 
    :: search
    maximize objective;

%------------------------------------------------------------------------------%
% Output item

output [ 
    if c = 1 then "% " else "" endif 
++  if grid[r,c] then show(xx[r,c]) else "#" endif 
++  if c = width then "\n" else "" endif
| r in ROW, c in COL 
] ++ [ 
    "ww = \(ww);\n",
    "objective = \(objective);\n",
] ;
