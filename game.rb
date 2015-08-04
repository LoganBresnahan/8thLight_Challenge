class Game
  def initialize
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
  end

  def start_game
    puts "Welcome to my Tic Tac Toe game. Who should go first, you or the computer? \nType '1' if you want to go first and '2' if you want the computer to go first."
		choose_turn
		puts "Would you like to be X's or O's?"
		symbol_choice
		puts "You will choose a spot that matches with the grid below."
    puts "|_#{@board[0]}_|_#{@board[1]}_|_#{@board[2]}_|\n|_#{@board[3]}_|_#{@board[4]}_|_#{@board[5]}_|\n|_#{@board[6]}_|_#{@board[7]}_|_#{@board[8]}_|\n"
  	if @computer == false
			until game_is_over(@board) || tie(@board)
      			get_human_spot
      			if !game_is_over(@board) && !tie(@board)
        		eval_board
      			end
    			end
		elsif @computer == true
			until game_is_over(@board) || tie(@board)
      			eval_board
      			if !game_is_over(@board) && !tie(@board)
        		get_human_spot
      			end
    			end
		else nil
		end
    puts "Game over"
  end

  def get_human_spot
    spot = nil
    until spot
			puts "\nIt is your turn."
      spot = gets.chomp.to_i
      if @board[spot] != "X" && @board[spot] != "O"
        @board[spot] = @hum
      else
				puts "You must select a number from the board."
        spot = nil
      end
    end
	puts "\nYou have chosen...\n|_#{@board[0]}_|_#{@board[1]}_|_#{@board[2]}_|\n|_#{@board[3]}_|_#{@board[4]}_|_#{@board[5]}_|\n|_#{@board[6]}_|_#{@board[7]}_|_#{@board[8]}_|\n"
  end

  def eval_board
    spot = nil
    until spot
      if @board[4] == "4"
        spot = 4
        @board[spot] = @com
      else
        spot = get_best_move(@board, @com)
        if @board[spot] != "X" && @board[spot] != "O"
          @board[spot] = @com
        else
          spot = nil
        end
      end
    end
	puts "\nThe computer is thinking... ('⌣̀_⌣́)"
	sleep 2.5
	puts "The computer has chosen...\n|_#{@board[0]}_|_#{@board[1]}_|_#{@board[2]}_|\n|_#{@board[3]}_|_#{@board[4]}_|_#{@board[5]}_|\n|_#{@board[6]}_|_#{@board[7]}_|_#{@board[8]}_|\n"
  end

  def get_best_move(board, next_player, depth = 0, best_score = {})
    available_spaces = []
    best_move = nil
    board.each do |s|
      if s != "X" && s != "O"
        available_spaces << s
      end
    end
    available_spaces.each do |as|
      board[as.to_i] = @com
      if game_is_over(board)
        best_move = as.to_i
        board[as.to_i] = as
        return best_move
      else
        board[as.to_i] = @hum
        if game_is_over(board)
          best_move = as.to_i
          board[as.to_i] = as
          return best_move
        else
          board[as.to_i] = as
        end
      end
    end
    if best_move
      return best_move
    else
      n = rand(0..available_spaces.count)
      return available_spaces[n].to_i
    end
  end

  def game_is_over(b)

    [b[0], b[1], b[2]].uniq.length == 1 ||
    [b[3], b[4], b[5]].uniq.length == 1 ||
    [b[6], b[7], b[8]].uniq.length == 1 ||
    [b[0], b[3], b[6]].uniq.length == 1 ||
    [b[1], b[4], b[7]].uniq.length == 1 ||
    [b[2], b[5], b[8]].uniq.length == 1 ||
    [b[0], b[4], b[8]].uniq.length == 1 ||
    [b[2], b[4], b[6]].uniq.length == 1
  end

  def tie(b)
    b.all? { |s| s == "X" || s == "O" }
  end

	def symbol_choice
		@symbol = gets.chomp.downcase
		if @symbol == "x"
				@hum = "X"
		elsif @symbol == "o"
						@hum = "O"
		else 
			puts "Sorry, you have to pick X or O"
			symbol_choice
		end
	
		if @hum == "X"
				@com = "O"
		elsif @hum == "O"
						@com = "X"
		else nil
		end
	end

	def choose_turn
		@choice = gets.chomp.to_i
		if @choice == 1
				@computer = false
		elsif @choice == 2
						@computer = true
		else 
			puts "You need to choose 1 for yourself or 2 for the computer."
			choose_turn
		end
	end

end

game = Game.new
game.start_game
