#!/bin/bash

readonly scriptsDir=$( cd "$(dirname "$0")" ; pwd -P )
readonly tmpDir="$scriptsDir"/../../tmp
readonly crosswordsDir="$scriptsDir"/../../cp/data/crosswords
readonly dictsDir="$scriptsDir"/../../cp/data/dicts
readonly modelsDir="$scriptsDir"/../../cp/models
readonly outputsDir="$scriptsDir"/../../results/parallel

sizes=(5 10 15 19 23)
solvers=(Chuffed CPOptimizer Gecode OR-Tools)

for solver in ${solvers[*]}
do
    for size in ${sizes[*]}
    do
        echo "$solver": "$size" 

        outputFile="$outputsDir"/"$solver"_"$size"_"$size".txt
        crosswordName=crossword_model_"$size"_"$size".dzn

        minizinc "$modelsDir"/model5.mzn "$dictsDir"/dict-80.dzn "$crosswordsDir"/"$crosswordName" -a -s -f --time-limit 60000 -p 10 > "$outputFile"
    done
done
