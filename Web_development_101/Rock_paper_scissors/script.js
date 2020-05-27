// These following 3 blocks are the event listeners for my buttons.

let rockListener = document.querySelector('#rock');
rockListener.addEventListener('click', () => {
	playerSelection = 'rock';
	return resultButton.textContent = playRound(playerSelection, computerPlay());
});

let paperListener = document.querySelector('#paper');
paperListener.addEventListener('click', () => {
	playerSelection = 'paper';
	return resultButton.textContent = playRound(playerSelection, computerPlay());
});

let scissorListener = document.querySelector('#scissors');
scissorListener.addEventListener('click', () => {
	playerSelection = 'scissors';
	return resultButton.textContent = playRound(playerSelection, computerPlay());
});

// Here is my element creation and append.

const resultButton = document.createElement('div');
gameResults.appendChild(resultButton);

// Here is the computer turns logic.

function computerPlay() {
 		let Options = ['rock', 'paper', 'scissors']
 		let computerSelection = Options[Math.floor(Math.random() * Options.length)];
 		return computerSelection;
 	}

// Here is each games logic.

 function playRound(playerSelection, computerSelection) {
	if ((playerScore == 5) || (computerScore == 5)) {
			return winner();
		} else if (playerSelection === computerSelection) {
			if ((playerScore == 5) || (computerScore == 5)) {
				return winner();
			} else {
 			return ('It\'s a tie this round! You have ' + playerScore + ' points and the computer has ' + computerScore + ' points.');
 		}} else if (playerSelection === 'rock' && computerSelection === 'scissors') {
 			playerScore += 1;
 			if ((playerScore == 5) || (computerScore == 5)) {
				return winner();
			} else {
 			return ('You win this round because the computer chose scissors! You have ' + playerScore + ' points and the computer has ' + computerScore + ' points.');
 		}} else if (playerSelection === 'rock' && computerSelection === 'paper') { 
 			computerScore += 1;
 			if ((playerScore == 5) || (computerScore == 5)) {
				return winner();
			} else {
 			return ('The computer player chose paper so they win this round! You have ' + playerScore + ' points and the computer has ' + computerScore + ' points.');
 		}} else if (playerSelection === 'paper' && computerSelection === 'scissors') { 
 			computerScore += 1;
 			if ((playerScore == 5) || (computerScore == 5)) {
				return winner();
			} else {
 			return ('The computer player chose scissors so they win this round! You have ' + playerScore + ' points and the computer has ' + computerScore + ' points.');
 		}} else if (playerSelection === 'paper' && computerSelection === 'rock') { 
 			playerScore += 1;
 			if ((playerScore == 5) || (computerScore == 5)) {
				return winner();
			} else {
 			return ('You win this round because the computer chose rock! You have ' + playerScore + ' points and the computer has ' + computerScore + ' points.');
 		}} else if (playerSelection === 'scissors' && computerSelection === 'paper') { 
 			playerScore += 1;
 			if ((playerScore == 5) || (computerScore == 5)) {
				return winner();
			} else {
 			return ('You win this round because the computer chose paper! You have ' + playerScore + ' points and the computer has ' + computerScore + ' points.');
 		}} else if (playerSelection === 'scissors' && computerSelection === 'rock') { 
 			computerScore += 1;
 			if ((playerScore == 5) || (computerScore == 5)) {
				return winner();
			} else {
 			return ('The computer player chose rock so they win this round! You have ' + playerScore + ' points and the computer has ' + computerScore + ' points.');
 		}} else {
 			return ('Something went wrong, maybe you mispelled your choice. Please try again.');
}
}

// Starting scores.

let playerScore = 0;
let computerScore = 0;

// Announcing the winner.

function winner() {
	if (playerScore == 5) {
		return ('You won!');
	} else {
		return ('The computer won!');
	}
}