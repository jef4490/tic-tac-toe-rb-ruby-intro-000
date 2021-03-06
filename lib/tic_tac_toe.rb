# Helper Methods
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter=0
  board.each do |space|
    if space == "X"
      counter += 1
    elsif space == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board)%2==0
    return "X"
  else
    return "O"
  end
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  #bottom row
  [0,3,6],  #left column
  [1,4,7],  #middle column
  [2,5,8],  #right column
  [0,4,8],  #diagnocal left
  [2,4,6]   #diagonal right
]

def won?(board)
  WIN_COMBINATIONS.find do |win_combo|
    win_index_1 = win_combo[0]
    win_index_2 = win_combo[1]
    win_index_3 = win_combo[2]
board[win_index_1] == board[win_index_2] && board[win_index_2] == board[win_index_3] && board[win_index_1] != " "

  end
end

def full?(board)
  (0..8).all? do |space|
    position_taken?(board, space)
  end
end

def draw?(board)
  if won?(board) != nil
    return false
  elsif full?(board) == false
    return false
  else return true
  end
end

def over?(board)
  if won?(board) != nil
    return true
  elsif draw?(board) == true
    return true
  else return false
  end
end

def winner(board)
if won?(board) != nil
  win_move = won?(board)
  board[win_move[0]]
else return nil
end
end

def play(board)
  until over?(board)
    turn(board)
  end
if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
