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
