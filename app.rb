#!/usr/bin/env ruby

require_relative 'lib/core'

deck = Deck.new(20)
piece = GamePiece.new(Coordinates.new(0, 0))
paul = Player.new({ name: 'Paul', deck: deck, game_piece: piece })

paul.take_turn
