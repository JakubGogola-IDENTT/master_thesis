using Base: Float64
using ArgParse

function parse_flags(args)
    s = ArgParseSettings()

    @add_arg_table s begin
        "--results-dir", "-r"
            help = "results directory"
            arg_type = String
            required = true
        "--output-dir", "-o"
            help = "output directory"
            arg_type = String
            default = "."
        "--file-name", "-f"
            help = "output file name"
            arg_type = String
            default = "table.txt"
    end

    return parse_args(args, s)
end

function matches(regexp, line)
    m = match(regexp, line)

    if m === nothing
        return false
    end

    return true
end

function parse_int_number(line)
    m = match(r"\d+", line)

    if m === nothing
        return 0
    end

    return parse(Int, m.match)
end

function parse_float_number(line)
    m = match(r"\d+\.\d+", line)

    if m === nothing
        return 0
    end

    return parse(Float64, m.match)
end

function parse_results(results_dir, output_dir, output_file_name)
    solvers = ["Chuffed", "CPOptimizer", "Gecode", "OR-Tools"]
    sizes = [5, 10, 15, 19, 23]

    # "solver,size,max_objective,steps,solve_time,variables"
    table = [
        "\\hline Solver & Rozmiar krzyżówki & \$ \\mathrm{max}(f_c)  \$ & Liczba kroków & Czas [\$s\$] & Liczba zmiennych \\\\ \\hline \n"
    ]

    for solver in solvers
        for (idx, size) in enumerate(sizes)
            file_name = "$(solver)_$(size)_$(size).txt"

            max_objective = 0
            steps = 0
            solve_time = 0
            variables = 0

            open("$(results_dir)/$(file_name)", "r") do f
                lines = readlines(f)

                for line in lines
                    if matches(r"\%\%\%mzn-stat: nSolutions=\d+", line)
                        steps = parse_int_number(line)
                    elseif  matches(r"\%\%\%mzn-stat: variables=\d+", line)
                        variables = parse_int_number(line)
                    elseif matches(r"\%\%\%mzn-stat: solveTime=\d+\.\d+", line)
                        solve_time = parse_float_number(line)
                    elseif matches(r"objective = \d+", line)
                        max_objective = parse_int_number(line)
                    end
                end
            end


            all_values = [max_objective, steps, solve_time, variables]
            parsed_values = ["\$ $(size) \\times $(size) \$"]

            for v in all_values
                if v == 0
                    parsed_values = push!(parsed_values, "-")
                    continue
                end

                parsed_values = push!(parsed_values, "$(v)")
            end

            first_col = " "

            if idx == 1
                first_col = "\\multirow{5}{*}{\\texttt{$(solver)}}"
            end

            pushfirst!(parsed_values, first_col)

            new_line = "$(join(parsed_values, " & ")) \\\\"

            if idx == 5
                new_line *= "\\hline\n"
            else
                new_line *= "\\cline{2-6}\n"
            end

            table = push!(
                table,
                new_line
            )
        end
    end

    open("$(output_dir)/$(output_file_name)", "w") do f
        for line in table
            write(f, line)
        end
    end
end

flags = parse_flags(ARGS)
results_dir = flags["results-dir"]
output_dir = flags["output-dir"]
file_name = flags["file-name"]

parse_results(results_dir, output_dir, file_name)


