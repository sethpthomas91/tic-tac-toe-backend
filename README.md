# Tic-Tac-Toe Backend

<!-- ABOUT THE PROJECT -->
## About The Project

This is a Tic-Tac-Toe backend made for my 8th Light apprenticeship. It focuses on using test driven development in order to build a robust program that stresses software development fundamentals. 

<!-- BUILD STATUS -->
## Current Project Status

INSERT STATUS BADGE HERE

<p align="right">(<a href="#top">back to top</a>)</p>


<!-- GETTING STARTED -->
## Getting Started


### Prerequisites

In order to run this project you will need to install Elixir and Pheonix.
```sh
Elixir 1.12
Pheonix 1.6.10
```


### Installation

1 Clone the repo
   ```sh
git clone 
   ```

2 Install dependencies 
   ```sh
mix deps.get 
   ```

3 Create and migrate your database with ``
   ```sh
mix ecto.setup
   ```

<p align="right">(<a href="#top">back to top</a>)</p>

### Starting the Server
1 Start the server
   ```sh
mix phx.server
   ```

2 Navigate to the local server in your browser.
   ```sh
http://localhost:4000/api/games
   ```

3 To close the server hold down control and press "c" twice.

<p align="right">(<a href="#top">back to top</a>)</p>

## Usage

### Creating a new game

In order to create a new game you need to send a POST request to 
   ```sh
http://localhost:4000/api/games
   ```
This POST request should include a body that is formatted like:
```
"game": {
        "available_moves" : [1, 2, 3, 4, 5, 6, 7, 8, 9],
        "won": false,
        "tied": false,
        "winner": 0,
        "player_1_moves" : [],
        "player_2_moves" : [],
        "player_1_mark" : "X",
        "player_2_mark" : "O",
        "current_player" : 1,
        "player_1_type" : ":human",
        "player_2_type" : ":human",
        "maximizer" : 1,
        "best_score_move" : {
            "best_score" : -100,
            "best_move" : 0
        },
        "board" : {
            1 : "1",
            2 : "2",
            3 : "3",
            4 : "4",
            5 : "5",
            6 : "6",
            7 : "7",
            8 : "8",
            9 : "9"
        }
```
### Playing a move

To play a game you only need to send a move to the API at the desired game. Make a POST request to:
   ```sh
http://localhost:4000/api/games/YOUR_GAME_NUMBER_HERE
   ```

The body of the POST request should be formatted like:
```
"move": MOVE_INTEGER_HERE
```

### Testing

1 After cloning the repo run the test suite with the following command
   ```sh
mix test 
   ```

<!-- ACKNOWLEDGMENTS -->
## Contributors

* [sethpthomas91](https://github.com/sethpthomas91)
