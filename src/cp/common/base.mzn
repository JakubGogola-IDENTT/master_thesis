% Height of crossword (number of cells in vertical).
int: height;

% Width of crossword (number of cells in horizontal).
int: width;

% Indices of rows (vertical).
set of int: ROWS = 1..height;

% Indices of columns (horizontal).
set of int: COLS = 1..width;

% Representation of all cells from crossword.
array[ROWS, COLS] of bool: grid;

% Lenght of the bigest set of words from dictionary.
int: max_words_set_size = max([
    words2,words3,words4,words5,words6,words7,words8,words9,
    words10,words11,words12,words13,words14,words15,words16,words17,words18,words19,
    words20,words21,words22,words23,words24,words25,words26,words27,words28,words29,
    words30,words31,words32,words33,words34,words35,words36,words37,words38,words39,
    words40,words41,words42,words43,words44,words45
]);

% Set of indices for words (it will match the bigest set of words from dictionary).
set of int: WORDS = 1..max_words_set_size;

% Number of clues in crossword.
int: number_of_clues;

% Set of indices for clues.
set of int: CLUES = 1..number_of_clues;

% Clues' coordinates (starting rows and columns)
array[CLUES] of ROWS: start_rows;
array[CLUES] of COLS: start_cols;

% Clues' direction (can be horizontal or vertical)
array[CLUES] of bool: is_vertical;

% Clues' lengths
array[CLUES] of int: lens;

% Array with allowed letters.
array[ROWS, COLS] of var LETTERS: ls;

% Array with allowed words.
array [CLUES] of var WORDS: ws;

int: total_size = width * height;
var min(weights) * total_size..max(weights) * total_size: objective; 

% Predicate which ensures that row of crossword matches 'legal' word.
predicate table_row(
    array [int] of var int: word, 
    array [int,int] of int: dict, 
    var int: row
) =
    forall(idx in index_set(word))(
        word[idx] = dict[row, idx]
    );

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
           else
              assert(len > 22, "word length too long \(len) > 22\n")
           endif
        endif
    )
);
