let box = document.querySelector('.box');
startingBoxCount = 16;
createGrid();

let lotsOfBoxes = document.querySelector('.lotsOfBoxes');
let newBoard;
var items = document.getElementsByClassName('lotsOfBoxes');


// Give the tiles a random rgb color.
function colorTiles() {
    let r = Math.floor(Math.random() * 256);
    let g = Math.floor(Math.random() * 256);
    let b = Math.floor(Math.random() * 256);
    let rgb = "rgb(" + r + "," + g + "," + b + ")";
    return rgb;
};
// Change the boxes colors.
box.onmouseover = function() {
    event.target.style.background = colorTiles();
};


// This is where I create all of my boxes.
function createGrid() {
for (i = 1; i <= startingBoxCount * startingBoxCount; i++) {
const childBox = document.createElement('div');
childBox.classList.add('lotsOfBoxes');
box.appendChild(childBox);
}
// Passes my grid size to css so the columns and rows are created.
box.style.gridTemplateColumns = `repeat(${startingBoxCount}, 1fr)`;
box.style.gridTemplateRows = `repeat(${startingBoxCount}, 1fr)`;
};


// Making my button clear out the board and ask the user for a new grid size.
document.getElementById('reset').onclick = function() {
    for (h = 0; h <= items.length; h++) {
        if (h <= items.length + -1) {
        items[h].style.background = 'white';
        } else {
            newBoard = prompt('How many squares would you like on the new board?');
            startingBoxCount = newBoard;
            deleteNodes();
            createGrid();
            break;
        }
}
};
// Deletes the nodes for a new game.
function deleteNodes() {
    while (box.lastChild) {
        box.removeChild(box.firstChild);
    }
};