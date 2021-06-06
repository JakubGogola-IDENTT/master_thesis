% Predicate which ensures that row of crossword matches 'legal' word.
predicate table_row(
    array [int] of var int: word, 
    array [int,int] of int: dict, 
    var int: row
) =
    forall(idx in index_set(word))(
        word[idx] = dict[row, idx]
    );
