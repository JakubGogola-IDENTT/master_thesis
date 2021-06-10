using ArgParse

function parse_flags(args)
    s = ArgParseSettings()

    @add_arg_table s begin
        "--rows", "-r"
            help = "number of rows"
            required = true
            arg_type = Int
        "--cols", "-c"
            help = "hnumber of columns"
            required = true
            arg_type = Int
        "--empty", "-e"
            help = "number of empty cells"
            arg_type = Int
            default = 0
        "--ouput-dir", "-o"
            help = "output dir"
            arg_type = String
            default = "."
    end

    return parse_args(args, s)
end

function generate_schema(rows, cols, empty_cells, output_dir)
    if empty_cells > (rows * cols) / 2
        throw(ErrorException("Empty cells can be only a half of all available cells"))
    end

    empty_positions = []

    while length(empty_positions) < empty_cells
        row = rand(1:rows)
        col = rand(1:cols)

        if any(item -> row == item[1] && col == item[2], empty_positions)
            continue
        end

        empty_positions = push!(empty_positions, (row, col))
    end

    schema = Array{Bool}(undef, rows, cols)

    for r in 1:rows
        for c in 1:cols
            schema[r, c] = true
        end
    end

    for cell in empty_positions
        r = cell[1]
        c = cell[2]

        schema[r, c] = false
    end

    file_name = "crossword_schema_$(rows)_$(cols).txt"

    open("$(output_dir)/$(file_name)", "w") do f
        for r in 1:rows
            line = "("
            for c in 1:cols
                if schema[r, c]
                    line *= "_"
                else
                    line *= "*"
                end
            end

            line *= ")\n"
            write(f, line)
        end
    end
end


flags = parse_flags(ARGS)

rows = flags["rows"]
cols = flags["cols"]
empty_cells = flags["empty"]
output_dir = flags["ouput-dir"]

generate_schema(rows, cols, empty_cells, output_dir)
