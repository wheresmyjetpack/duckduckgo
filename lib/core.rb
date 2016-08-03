class Player
  attr_reader :name

  def initialize(name, game_piece, deck)
    @name = name
    @game_piece = game_piece
    @deck = deck
  end

  public
  def take_turn
    move_piece(draw)
  end

  private
  def draw
    deck.get_card
  end

  def move_piece(directions)
    game_piece.move(directions)
  end
end

class Deck
  def initialize(size)
    @size = size
  end

  public
  def get_card
    new_card
  end

  private
  def new_card
    Card.new
  end
end

class Card
  attr_reader :directions

  def initialize
    @directions = Array.new(2) { rand(-4...4) }
  end
end

class Tub
end

class GamePiece
  attr_accessor :position

  def initialize
  end

  def move
  end
end
