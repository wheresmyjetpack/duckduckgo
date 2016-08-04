#!/usr/bin/env ruby

require_relative 'lib/core'

board = Board.new(Coordinates.new(4, 4))
piece = GamePiece.new(board, Coordinates.new(0, 0))
deck = Deck.new(20)
paul = Player.new({ name: 'Paul', deck: deck, game_piece: piece })

puts "Starting the game with the following buoys:"
puts board.buoys

3.times { paul.take_turn }
