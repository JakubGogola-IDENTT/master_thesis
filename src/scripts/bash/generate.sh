#!/bin/bash

readonly scriptsDir=$( cd "$(dirname "$0")" ; pwd -P )
readonly tmpDir="$scriptsDir"/../../tmp
readonly juliaScriptsDir="$scriptsDir"/../julia

julia "$juliaScriptsDir/generate_data.jl" --min 2 --max 23 --schemas-dir "$tmpDir/schemas" --models-dir "$tmpDir/models" --scripts-dir "$juliaScriptsDir"
