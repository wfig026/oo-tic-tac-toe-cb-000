class TicTacToe
  #initialize @board
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  #WIN_COMBINATIONS
  WIN_COMBINATIONS = [
    [0,1,2], # top row
    [3,4,5], # middle row
    [6,7,8], # bottom row
    [0,3,6], # lef column
    [1,4,7], # middle column
    [2,5,8], # right column
    [0,4,8], # left to right diagonal
    [2,4,6]  # right to left diagonal
  ]

  #display_board
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  #input_to_index
  def input_to_index(input)
    index = input.to_i - 1
  end

  #move
  def move(index, token="X")
    @board[index] = token
  end

  #position_taken?
  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  #valid_move?
  def valid_move?(index)
    if position_taken?(index) == false && index.between(0,8)
      true
    end
  end

  #turn
  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    until valid_move?(index) == true
      puts "Please enter 1-9:"
      input = gets.strip
      index = input_to_index(input)
    end
    token = current_player
    move(index, token)
    display_board
  end

  #turn_count
  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  #current_player
  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  #won?
  def won?
    WIN_COMBINATIONS.detect do |win_combination|
      if
        win_combination.all? do |win_index|
          @board[win_index]=="X"
        end
        true
      elsif
        win_combination.all? do |win_index|
          @board[win_index]=="O"
        end
        true
      else
        nil
      end
    end
  end

  #full
  def full?
    @board.all? do |index|
      index == "X" || index == "O"
    end
  end

  #draw?
  def draw?
    if full? == true && won? == nil
      true
    end
  end

  #over?
  def over?
    if won? != nil || full? == true
      true
    else
      false
    end
  end

  #winner
  def winner
    if won? != nil
      @board[won?.detect {|index| @board[index] == "X" || @board[index] == "O"}]
    else
      nil
    end
  end

  #play
  def play
    until over? == true || won? != nil || draw? == true
      turn
    end
    if won? != nil
      puts "Congratulations #{winner}!"
    elsif draw? == true
      puts "Cat's Game!"
    end
    won?
  end

end
