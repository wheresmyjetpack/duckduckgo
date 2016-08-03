#!/usr/bin/env ruby

require_relative 'lib/core'
deck = Deck.new(20)
piece = GamePiece.new
paul = Player.new({ name: 'Paul', deck: deck })

paul.take_turn
