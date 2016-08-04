#!/usr/bin/env ruby

require_relative 'lib/core'

def winner?(player, buoys)
  buoys & player.buoys == buoys
end

board = Board.new(Coordinates.new(6, 6))
deck = Deck.new(100)
buoys = board.buoys

puts "Welcome to Duck Duck Go!"
puts "How many players? "
num_players = gets.to_i

players = []
num_players.times do |p|
  puts "Player #{p + 1} name: "
  players << Player.new({ 
    name: gets.chomp, 
    deck: deck, 
    game_piece: GamePiece.new(board, Coordinates.new((board.width / 2), (board.height / 2)))
  })
end

game_over = false

while not game_over 
  players.each do |player|
    position = player.piece_position

    puts "#{player.name}'s turn"
    puts "Starting at #{position.x}, #{position.y}"

    player.take_turn
    new_position = player.piece_position

    unless new_position == position
      puts "Moved to #{new_position.x}, #{new_position.y}"
      puts "Landed on a buoy!" if player.piece_on_buoy?
    else
      puts "The move will take you off the board, staying put!"
    end

    puts

    if winner?(player, buoys)
      puts "#{player.name} wins!!!"
      game_over = true
      break
    end

    if deck.cards_count == 0
      puts "No more cards left in the deck..."
      game_over = true
      break
    end
  end
end

puts "Game over"
