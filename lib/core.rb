Coordinates = Struct.new(:x, :y)

class Player
  attr_reader :name

  def initialize(args)
    @name = args[:name] || 'Sally Roe'
    @game_piece = args[:game_piece]
    @deck = args[:deck]
  end

  public
  def take_turn
    move_piece(follow_directions)
  end

  private
  def draw
    @deck.get_card
  end

  def move_piece(directions)
    @game_piece.move(directions)
  end

  def follow_directions
    draw.directions
  end
end


class Deck
  def initialize(size)
    @size = size
  end

  public
  def get_card
    cards.pop
  end

  private
  def cards
    @cards ||= Array.new(@size) { Card.new }
  end

end

class Card
  attr_reader :directions

  public
  def directions
    @directions ||= create_directions
  end

  private
  def create_directions
    Coordinates.new(rand(-4...4), rand(-4...4))
  end
end


class Board
end


class GamePiece
  attr_reader :position

  def initialize(starting_position)
    @position = starting_position
  end

  public
  def move(directions)
    update_position(directions)
  end

  private
  def update_position(directions)
    puts "Starting at #{position.x}, #{position.y}"
    puts "Directions: #{directions.x}, #{directions.y}"
    move_horizontally(directions)
    move_vertically(directions)
    puts "Moved to #{position.x}, #{position.y}"
  end

  def move_horizontally(directions)
    @position.x += directions.x
  end

  def move_vertically(directions)
    @position.y += directions.y
  end
end
