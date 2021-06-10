"""
This script allows to generate file using file with crossword schema like this:

(_ _ _ * *)
(_ _ _ _ *)
(_ _ _ _ _)
(* _ _ _ _)
(* * _ _ _)

It transforms the schema into problem instance which is readable for MiniZinc model.
For every row and column a clue is assigned. 
In case of given example there will be 10 clues - 5 vertical and 5 horizontal.

The name of file to parse should be passed as argument when program is called in terminal:

This script will output an problem instance named 'crossword_m_n_c.mzn' 
where m and n describes size of crossword and c describes number of clues.
"""

using ArgParse

function parse_flags(args)
    s = ArgParseSettings()

    @add_arg_table s begin
        "--schema", "-s"
            help = "schema of crossword"
            arg_type = String
            required = true
        "--ouput-dir", "-o"
            help = "output dir"
            arg_type = String
            default = "."
    end
     
    return parse_args(args, s)
end

function parse_schema(file_content)   
    grid = []

    for line in file_content
        cells = []

        filtered = filter(c -> c in "(_*)", line)
        m = match(r"\([_\*]+\)", filtered)

        if m === nothing 
            continue
        end

        for c in m.match
            if c == '*'
                cells = append!(cells, false)
            elseif c == '_'
                cells = append!(cells, true)
            end
        end

        if length(cells) == 0
            continue
        end

        grid = push!(grid, cells)
    end

    return grid
end

function get_size(grid)
    height = length(grid)
    width = length(grid[1])

    return width, height
end

function get_clues(grid)
    width, height = get_size(grid)

    number_of_clues = 0
    start_rows = []
    start_cols = []
    is_vertical = []
    lens = []

    # horizontal
    row = 1
    while row <= height
        col = 1
        while col < width
            cell = grid[row][col]

            if !cell
                col += 1
                continue
            end

            r = row
            c = col
            start_rows = append!(start_rows, r)
            start_cols = append!(start_cols, c)
            is_vertical = append!(is_vertical, false)
            number_of_clues += 1

            len = -1
            next = cell

            while next && col <= width
                next = grid[row][col]
                len += 1
                col += 1
            end

            lens = append!(lens, len)
        end

        row += 1
    end

    # vertical
    col = 1
    while col <= width
        row = 1
        while row < height
            cell = grid[row][col]
    
            if !cell
                row += 1
                continue
            end
    
            r = row
            c = col
            start_rows = append!(start_rows, r)
            start_cols = append!(start_cols, c)
            is_vertical = append!(is_vertical, true)
            number_of_clues += 1
    
            len = -1
            next = cell
    
            while next && row <= height
                next = grid[row][col]
                len += 1
                row += 1
            end
    
            lens = append!(lens, len)
        end
    
        col += 1
    end

    return (number_of_clues, start_rows, start_cols, is_vertical, lens)
end

function print_array(array, with_brackets=true)
    concat = join(array, ",")
    
    if !with_brackets
        return concat
    end

    return "[$(concat)]"
end

function generate_instance_file(grid, output_dir)
    width, height = get_size(grid)
    number_of_clues, start_rows, start_cols, is_vertical, lens = get_clues(grid)

    name = "crossword_$(width)_$(height)_$(number_of_clues).dzn"

    open("$(output_dir)/$(name)", "w") do f
        write(f, "width = $(width);\n")
        write(f, "height = $(height);\n\n")

        write(f, "grid = \n")

        for (idx, row) in enumerate(grid)
            if idx == 1
                write(f, "[")
            end

            write(f, "| $(print_array(row, false))\n")
        end

        write(f, "|];\n")
        write(f, "number_of_clues = $(number_of_clues);\n")
        write(f, "start_rows = $(print_array(start_rows));\n")
        write(f, "start_cols = $(print_array(start_cols));\n")
        write(f, "is_vertical = $(print_array(is_vertical));\n")
        write(f, "lens = $(print_array(lens));\n")
    end
end

flags = parse_flags(ARGS)

schema_path = flags["schema"]
output_dir = flags["ouput-dir"]

open(schema_path) do f
    content = readlines(f)
    grid = parse_schema(content)

    generate_instance_file(grid, output_dir)
end
