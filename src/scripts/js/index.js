import fs from 'fs';
import canvas from 'canvas';
import yargs from 'yargs';
import paper from 'paper';
import { hideBin } from 'yargs/helpers';

const { argv: { inputFile, outputDir } } = await  yargs(hideBin(process.argv))
    .option('inputFile', {
        alias: 'i',
        type: 'string',
        description: 'Path to input file with crossword schema',
    })
    .option('outputDir', {
        alias: 'o',
        type: 'string',
        description: 'Path to output directory'
    })
    .demandOption(['inputFile', 'outputDir'], 'You need to define both params')
    .help()

const schema = fs.readFileSync(inputFile, 'UTF-8')

const lines = schema.split(/\r?\n/);

let cols = 0;
let rows = 0;

const grid = lines.reduce((acc, line) => {
    const match = line.match(/[a-z\*]+/);

    if (!match) {
        return acc;
    }

    rows++;

    const [row] = match;

    if (cols === 0) {
        cols = row.length;
    }

    if (cols !== 0 && row.length !== cols) {
        throw Error('Invalid width of row');
    }

    return [
        ...acc,
        row.split('')
    ];
}, []);

const MULT = 10;
const width = rows * MULT;
const height = cols * MULT;

const size = new paper.Size(width, height);
paper.setup(size);

grid.forEach((row, y) => 
    grid.forEach((col, x) => {
        const posX = x * MULT;
        const posY = y * MULT;

        const rect = new paper.Rectangle(
            new paper.Point(posX, posY),
            new paper.Size(MULT, MULT)
        );

            console.log(rect)

        const path = new paper.Path.Rectangle(rect);
        
        if (col == '*') {
            path.fillColor = '#f00';
        } else {
            path.fillColor = '#0f0';
        }

        path.selected = true;
    })
);

var svg = paper.project.exportSVG({
    asString: true,
});

fs.writeFileSync(`${outputDir}/result.svg`, svg)
