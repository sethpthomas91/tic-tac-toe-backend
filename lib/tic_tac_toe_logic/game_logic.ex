defmodule GameLogic do
  @new_game %{
    :available_moves => [1, 2, 3, 4, 5, 6, 7, 8, 9],
    :won => false,
    :tied => false,
    :winner => nil,
    :player_1_moves => [],
    :player_2_moves => [],
    :player_1_mark => "X",
    :player_2_mark => "O",
    :current_player => 1,
    :player_1_type => :human,
    :player_2_type => :human,
    :maximizer => nil,
    :best_score_move => %{
      :best_score => -100,
      :best_move => nil
    },
    :board => %{
      1 => "1",
      2 => "2",
      3 => "3",
      4 => "4",
      5 => "5",
      6 => "6",
      7 => "7",
      8 => "8",
      9 => "9"
    }
  }

  def convert_schema_to_map(game) do
    Map.drop(game, [:__meta__, :__struct__, :inserted_at, :updated_at])
  end

  def handle_game_logic(game, move) do
    if (game[:tied] || game[:won]) do
      game
    else
      new_game_data =
        handle_move(move, game)
        |> check_for_win()
        |> check_for_tie()
        |> change_player()
    end
  end

  def new, do: @new_game

  def won(game), do: game[:won]

  def assign_player_1_mark(marker, game), do: %{game | player_1_mark: marker}

  def assign_player_2_mark(marker, game), do: %{game | player_2_mark: marker}

  def assign_game_win(false, game), do: game
  def assign_game_win(won, game), do: %{game | won: won, winner: game.current_player}


  def check_for_tie(game) do
    if (length(get_available_moves(game)) == 0 && !won(game)) do
      %{game | tied: true}
    else
      game
    end
  end

  def check_for_win(game) do
    won =
      game[determine_move_list(game)]
      |> check_for_win_combos()

    assign_game_win(won, game)
  end

  def check_for_win_combos(moves) do
    win_combos = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
      [1, 4, 7],
      [2, 5, 8],
      [3, 6, 9],
      [1, 5, 9],
      [3, 5, 7]
    ]

    win_combo_list =
      Enum.map(win_combos, fn combo ->
        Enum.map(combo, fn num ->
          num in moves
        end)
      end)

    win_list =
      Enum.map(win_combo_list, fn combo ->
        Enum.all?(combo)
      end)

    Enum.any?(win_list)
  end

  def change_player(game) when game.current_player == 1, do: %{game | current_player: 2}
  def change_player(game), do: %{game | current_player: 1}

  def determine_move_list(game) when game.current_player == 1, do: :player_1_moves
  def determine_move_list(_game), do: :player_2_moves

  def handle_move(move, game) do
    player_move_list = determine_move_list(game)
    game = update_available_moves(move, game)
    game = update_player_move_list(game, player_move_list, move)
    place_marker(move, game)
  end

  def update_available_moves(move, game) do
    %{game | available_moves: List.delete(game.available_moves, move)}
  end

  def update_player_move_list(game, player_move_list, move) do
    Map.replace(game, player_move_list, [move | game[player_move_list]])
  end

  def get_current_player(game), do: game[:current_player]

  def get_available_moves(game), do: game[:available_moves]

  def remove_move_from_available_moves(move, game),
    do: List.delete(get_available_moves(game), move)

  def get_random_move(game), do: Enum.random(get_available_moves(game))

  def assign_player_2_type(type, game), do: %{game | player_2_type: type}
  def assign_player_1_type(type, game), do: %{game | player_1_type: type}

  def get_current_player_type(game) when game.current_player == 1, do: game.player_1_type
  def get_current_player_type(game), do: game.player_2_type

  # def determine_move_type(game) do
  #   case get_current_player_type(game) do
  #     :human -> handle_move(Display.get_user_move(game), game)
  #     :random -> handle_random_move(game)
  #     :next -> handle_next_move(game)
  #     :best -> handle_move(best_move(game), game)
  #   end
  # end

  def handle_random_move(game) do
    move = get_random_move(game)
    player_move_list = determine_move_list(game)
    game = update_available_moves(move, game)
    game = update_player_move_list(game, player_move_list, move)
    place_marker(move, game)
  end

  def place_marker(move, game) do
    update_board(Map.replace(game.board, Integer.to_string(move), get_marker(game)), game)
  end

  def get_marker(game) when game.current_player == 1, do: game.player_1_mark
  def get_marker(game), do: game.player_2_mark

  def update_board(board, game), do: %{game | board: board}

  def next_open(game), do: List.first(get_available_moves(game))

  def handle_next_move(game) do
    move = next_open(game)
    player_move_list = determine_move_list(game)
    game = update_available_moves(move, game)
    game = update_player_move_list(game, player_move_list, move)
    place_marker(move, game)
  end

  def best_move(game) do
    assign_maximizer(game)
    |> minimax()
  end

  def assign_maximizer(game), do: %{game | maximizer: game.current_player}

  def assign_winner(game), do: %{game | winner: game.current_player}

  def score(%{won: false, available_moves: []}), do: 0
  def score(%{winner: winner, won: true, maximizer: maximizer}) when winner == maximizer, do: 10
  def score(%{won: true}), do: -10
  def score(game), do: game

  def terminal_state(%{won: false, available_moves: []}), do: true
  def terminal_state(%{won: true}), do: true
  def terminal_state(_), do: false

  def minimax(game) do
    game = check_for_win(game)

    if terminal_state(game) do
      score(game)
    else
      next_games =
        Enum.map(game.available_moves, fn move ->
          game = handle_move(move, change_player(game))
          %{game | best_score_move: %{:best_score => minimax(game), :best_move => move}}
        end)

      case game.current_player == game.maximizer do
        true ->
          best_game = Enum.min_by(next_games, fn game -> game.best_score_move.best_score end)
          best_game.best_score_move.best_move

        false ->
          best_game = Enum.max_by(next_games, fn game -> game.best_score_move.best_score end)
          best_game.best_score_move.best_move
      end
    end
  end
end
