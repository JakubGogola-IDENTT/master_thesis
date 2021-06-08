% Main objective.
constraint objective = sum(row in ROWS, col in COLS)( 
    weights[ 
        ls[row, col] 
    ] 
);

% Constraint which ensures that every clue in crossword occurs only once.
constraint forall(letter in 2..22)(
    alldifferent(clue in CLUES where lens[clue] = letter)(ws[clue])
);

% Constraint which preassigns all 'black' cells with  letter 'a'.
constraint forall(row in ROWS, col in COLS)(
    not grid[row, col] -> ls[row, col] = a
);

% constraint which ensures that word belongs to dictionary.
constraint forall(clue in CLUES)(
    let { 
        int: row = start_rows[clue]; 
        int: col = start_cols[clue]; 
    } in (
        if is_vertical[clue] then
           % Vertical word starting at [row, col] position.
           let {int: len = lens[clue]; 
                array[int] of var LETTERS: clueword = [ ls[idx, col] | idx in row..row + len - 1 ];
               } in
           if len = 1 then table_row(clueword, dict1, ws[clue])
           elseif len =  2 then table_row(clueword, dict2, ws[clue])
           elseif len =  3 then table_row(clueword, dict3, ws[clue])
           elseif len =  4 then table_row(clueword, dict4, ws[clue])
           elseif len =  5 then table_row(clueword, dict5, ws[clue])
           elseif len =  6 then table_row(clueword, dict6, ws[clue])
           elseif len =  7 then table_row(clueword, dict7, ws[clue])
           elseif len =  8 then table_row(clueword, dict8, ws[clue])
           elseif len =  9 then table_row(clueword, dict9, ws[clue])
           elseif len = 10 then table_row(clueword, dict10, ws[clue])
           elseif len = 11 then table_row(clueword, dict11, ws[clue])
           elseif len = 12 then table_row(clueword, dict12, ws[clue])
           elseif len = 13 then table_row(clueword, dict13, ws[clue])
           elseif len = 14 then table_row(clueword, dict14, ws[clue])
           elseif len = 15 then table_row(clueword, dict15, ws[clue])
           elseif len = 16 then table_row(clueword, dict16, ws[clue])
           elseif len = 17 then table_row(clueword, dict17, ws[clue])
           elseif len = 18 then table_row(clueword, dict18, ws[clue])
           elseif len = 19 then table_row(clueword, dict19, ws[clue])
           elseif len = 20 then table_row(clueword, dict20, ws[clue])
           elseif len = 21 then table_row(clueword, dict21, ws[clue])
           elseif len = 22 then table_row(clueword, dict22, ws[clue])
           elseif len = 23 then table_row(clueword, dict23, ws[clue])
           else 
              assert(len > 22, "word length too long \(len) > 22\n")
           endif
        else 
           % Horizontal word starting at [row, col] position.
           let {int: len = lens[clue]; 
                array[int] of var LETTERS: clueword = [ ls[row, idx] | idx in col..col + len - 1 ];
                } in 
           if len = 1 then table_row(clueword, dict1, ws[clue])
           elseif len = 2 then table_row(clueword, dict2, ws[clue])
           elseif len = 3 then table_row(clueword, dict3, ws[clue])
           elseif len = 4 then table_row(clueword, dict4, ws[clue])
           elseif len = 5 then table_row(clueword, dict5, ws[clue])
           elseif len = 6 then table_row(clueword, dict6, ws[clue])
           elseif len = 7 then table_row(clueword, dict7, ws[clue])
           elseif len = 8 then table_row(clueword, dict8, ws[clue])
           elseif len = 9 then table_row(clueword, dict9, ws[clue])
           elseif len = 10 then table_row(clueword, dict10, ws[clue])
           elseif len = 11 then table_row(clueword, dict11, ws[clue])
           elseif len = 12 then table_row(clueword, dict12, ws[clue])
           elseif len = 13 then table_row(clueword, dict13, ws[clue])
           elseif len = 14 then table_row(clueword, dict14, ws[clue])
           elseif len = 15 then table_row(clueword, dict15, ws[clue])
           elseif len = 16 then table_row(clueword, dict16, ws[clue])
           elseif len = 17 then table_row(clueword, dict17, ws[clue])
           elseif len = 18 then table_row(clueword, dict18, ws[clue])
           elseif len = 19 then table_row(clueword, dict19, ws[clue])
           elseif len = 20 then table_row(clueword, dict20, ws[clue])
           elseif len = 21 then table_row(clueword, dict21, ws[clue])
           elseif len = 22 then table_row(clueword, dict22, ws[clue])
           elseif len = 23 then table_row(clueword, dict23, ws[clue])
           else
              assert(len > 22, "word length too long \(len) > 22\n")
           endif
        endif
    )
);
