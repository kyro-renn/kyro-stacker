function StackerGame() {
  // Game constants and state initialization
  this.BOARD_WIDTH = 7;
  this.BOARD_HEIGHT = 15;
  this.LIMIT_3 = 2;
  this.LIMIT_2 = 7;
  this.MIN_SPEED = (6/64);
  this.MAX_SPEED = (2/64);
  this.ANIMATION_TIME = 1.5 * 60;

  // Initialize members
  this.gameElement = document.getElementById('stacker-game');
  this.gameBoard = null;

  // Initialize board state
  this.board = new Array(this.BOARD_HEIGHT);
  for (let i = 0; i < this.BOARD_HEIGHT; i++) {
    this.board[i] = new Array(this.BOARD_WIDTH).fill(0);
  }

  // Game state variables
  this.blocks = 3;
  this.running = false;
  this.level = 0;
  this.pos = Math.floor(this.BOARD_WIDTH / 2) - Math.floor(this.blocks / 2);
  this.left = true;
  this.timer = 0;
  this.atimer = 0;

  // Flag to track if the message has been printed
  this.levelReached = false;

  // Method to build HTML elements for the game
  this.buildHTML = function () {
    const domTable = document.createElement('table');
    for (let i = 0; i < this.BOARD_HEIGHT; i++) {
      const domTableRow = domTable.insertRow(i);
      for (let j = 0; j < this.BOARD_WIDTH; j++) {
        domTableRow.insertCell(j);
      }
    }
    domTable.classList.add('stacker-board');
    this.gameBoard = domTable;
    this.gameElement.appendChild(this.gameBoard);
  };

  // Method to start the game
  this.run = function () {
    setInterval(() => this.onStep(), 1000 / 60);
    window.addEventListener("keydown", (e) => this.onKeyPress(e)); // Attach keydown event once
    this.gameBoard.addEventListener("touchstart", (e) => this.onTouchStart(e));
  };

 // Handle each step event for the game
// Add a flag to track if the game has been closed
this.gameClosed = false;

this.onStep = function () {
  if (this.atimer > 0) this.atimer--;
  if (this.atimer == 0) {
    for (let i = 0; i < this.BOARD_HEIGHT; i++) {
      for (let j = 0; j < this.BOARD_WIDTH; j++) {
        if (this.board[i][j] == 2) this.board[i][j] = 0;
      }
    }

    if (this.blocks == 0 && !this.gameClosed) { // Check if the game has already been closed
      this.running = false;
      this.gameClosed = true; // Set the flag to true to prevent further printing

      setTimeout(() => {
 

        // Ensure closeStackerGame is a valid function
        if (typeof this.closeStackerGame === 'function') {
          this.closeStackerGame();
        } else {
          console.error('closeStackerGame is not defined or is not a function.');
        }

        // Ensure post request is sent
        $.post('https://kyro-stacker/Stacker:Close', {}, (response) => {

        }).fail((error) => {
          console.error('Error sending game close request:', error);
        });

        // Reset the gameClosed flag after 5 seconds
        setTimeout(() => {
          this.gameClosed = false;
       
        }, 5000);  // Reset after 5 seconds
      }, 1000);  // Close game after 2 seconds
    }
  }

  if (this.running && this.atimer == 0) {
    if (this.timer <= 0) {
      if (this.left) {
        this.pos--;
        if (this.pos + this.blocks - 1 == 0) {
          this.left = false;
        }
      } else {
        this.pos++;
        if (this.pos == this.BOARD_WIDTH - 1) {
          this.left = true;
        }
      }
      this.timer = (this.MAX_SPEED + ((this.MIN_SPEED - this.MAX_SPEED) * (1 - (this.level / this.BOARD_HEIGHT)))) * 60;
    } else {
      this.timer--;
    }
  }

  for (let i = 0; i < this.BOARD_HEIGHT; i++) {
    for (let j = 0; j < this.BOARD_WIDTH; j++) {
      switch (this.board[i][j]) {
        case 0:
          this.gameBoard.rows[this.BOARD_HEIGHT - 1 - i].cells[j].className = "";
          break;
        case 1:
          this.gameBoard.rows[this.BOARD_HEIGHT - 1 - i].cells[j].className = "filled";
          break;
        case 2:
          this.gameBoard.rows[this.BOARD_HEIGHT - 1 - i].cells[j].className = (this.atimer > 0 && this.atimer % 30 < 15 ? "filled" : "");
          break;
      }
    }
  }

  if (this.running && this.atimer == 0) {
    for (let j = this.pos; j < this.pos + this.blocks; j++) {
      if (j >= 0 && j < this.BOARD_WIDTH) {
        this.gameBoard.rows[this.BOARD_HEIGHT - 1 - this.level].cells[j].className = "filled";
      }
    }
  }

  if (this.level > 0 && !this.levelReached) {
    $.post('https://kyro-stacker/Stacker:CurrentLevel', JSON.stringify({ level: this.level }));
    this.levelReached = true; // Prevent the message from being printed multiple times
  }
};



  // Handle keyboard press events
  this.onKeyPress = function (e) {
    switch (e.keyCode) {
      case 32: // Space
        this.onSpacePress();
        e.preventDefault();
        break;
      case 13: // Enter/return
        this.onEnterPress();
        e.preventDefault();
        break;
      
    }
  };

  // Handle touch start on screen devices
  this.onTouchStart = function (e) {
    if (this.running) {
      this.onSpacePress();
    } else {
      this.onEnterPress();
    }
  };

  this.onSpacePress = function () {
    if (!this.running) {
      this.onEnterPress(); // Handle when the game isn't running
    } else if (this.atimer != 0) {
      // Handle case when animation timer is not zero (optional logic can go here)
    } else {
      const iEnd = this.pos + this.blocks;
      for (let i = this.pos; i < iEnd; i++) {
        if (i >= 0 && i < this.BOARD_WIDTH) {
          this.board[this.level][i] = 1;
        } else {
          this.blocks--;
        }
      }
  
      if (this.level > 0) {
        for (let i = 0; i < this.BOARD_WIDTH; i++) {
          if (this.board[this.level][i] == 1 && this.board[this.level - 1][i] == 0) {
            this.board[this.level][i] = 2;
            this.blocks--;
            this.atimer = this.ANIMATION_TIME;
          }
        }
      }
  
      if (this.blocks >= 3 && this.level >= this.LIMIT_3) {
        this.blocks = 2;
      }
      if (this.blocks >= 2 && this.level >= this.LIMIT_2) {
        this.blocks = 1;
      }
      if (this.level == this.BOARD_HEIGHT - 1) {
        this.running = false;
      }
  
      this.level++;
      this.pos = Math.floor(this.BOARD_WIDTH / 2);
      this.levelReached = false; // Reset levelReached flag when a new level starts
    }
  };
  
  
  // Handle enter/return presses
  this.onEnterPress = function () {
    for (let i = 0; i < this.BOARD_HEIGHT; i++) {
      for (let j = 0; j < this.BOARD_WIDTH; j++) {
        this.board[i][j] = 0;
      }
    }

    this.level = 0;
    this.blocks = 3;
    this.pos = Math.floor(this.BOARD_WIDTH / 2) - Math.floor(this.blocks / 2);
    this.left = true;
    this.running = true;
    this.atimer = 0;
    this.levelReached = false; // Reset flag for the new game
  };

  // Close the game
  this.closeStackerGame = function () {
    document.body.style.display = "none";
    this.running = false;
    $.post('https://kyro-stacker/Stacker:Close');
  };
}

// Initialize the game
let game = null;
window.addEventListener("DOMContentLoaded", function () {
  game = new StackerGame();
  game.buildHTML();
  game.run();
});

// Handle messages to open or close the game
window.addEventListener("message", function (event) {
  if (event.data.action === "openStackerGame") {
    document.body.style.display = "block";  // Show the game UI
    
    // If the game is not already initialized, initialize and start it
    if (!game) {
      game = new StackerGame();  // Create a new game instance
      game.buildHTML();  // Build the HTML elements for the game
      game.run();  // Start the game logic
    } else {
      // Reset game state to start a fresh game
      game.level = 0;
      game.blocks = 3;
      game.pos = Math.floor(game.BOARD_WIDTH / 2) - Math.floor(game.blocks / 2);
      game.left = true;
      game.timer = 0;
      game.atimer = 0;
      game.running = true;
      game.levelReached = false;  // Reset the levelReached flag for the new game
      // You may want to clear the board and UI elements here as well
      for (let i = 0; i < game.BOARD_HEIGHT; i++) {
        for (let j = 0; j < game.BOARD_WIDTH; j++) {
          game.board[i][j] = 0;  // Clear the board
        }
      }
    }
  } else if (event.data.action === "closeStackerGame") {
    document.body.style.display = "none";  // Hide the game UI
    if (game) {
      game.closeStackerGame();  // Close the game and clean up
    }
  }
});
