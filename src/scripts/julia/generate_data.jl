using ArgParse

function parse_flags(args)
    s = ArgParseSettings()

    @add_arg_table s begin
        "--min", "-l"
            help = "lower bound"
            arg_type = Int
            required = true
        "--max", "-u"
            help = "upper bound"
            arg_type = Int
            required = true
        "--schemas-dir", "-s"
            help = "schemas directory"
            arg_type = String
            required = true
        "--models-dir", "-m"
            help = "models directory"
            arg_type = String
            required = true
        "--scripts-dir", "-c"
            help = "scripts directory"
            arg_type = String
            required = true
    end

    return parse_args(args, s)
end

function generate(lower_bound, upper_bound, schemas_dir, models_dir, scripts_dir)
    for size in lower_bound:upper_bound
        cmd = `julia $(scripts_dir)/generate_schema.jl -r $(size) -c $(size) -e $(size) -o $(schemas_dir)`
        run(cmd)

        schema_file_name = "crossword_schema_$(size)_$(size).txt"
        cmd = `julia $(scripts_dir)/generate_instance.jl -s $(schemas_dir)/$(schema_file_name) -o $(models_dir)`
        run(cmd)
    end
end

flags = parse_flags(ARGS)

lower_bound = flags["min"]
upper_bound = flags["max"]
schemas_dir = flags["schemas-dir"]
models_dir = flags["models-dir"]
scripts_dir = flags["scripts-dir"]

generate(lower_bound, upper_bound, schemas_dir, models_dir, scripts_dir)
