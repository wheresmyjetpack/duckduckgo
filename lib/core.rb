class Player
  attr_reader :name

  def initialize(name, duck, deck)
    @name = name
    @duck = duck
    @deck = deck
  end

  public
  def take_turn
  end

  private
  def draw
    deck.get_card
  end

  def move_piece(directions)
    duck.move(directions)
  end
end

class Deck
  def initialize
  end

  def get_card
  end
end

class Tub
end

class Duck
  attr_accessor :position

  def initialize
  end

  def move
  end
end
