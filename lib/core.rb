Coordinates = Struct.new(:x, :y)

class Player
  attr_reader :name, :buoys

  def initialize(args)
    @name = args[:name] || 'Sally Roe'
    @game_piece = args[:game_piece]
    @deck = args[:deck]
    @buoys = []
  end

  public
  def take_turn
    move_piece(follow_directions)
  end

  def piece_position
    @game_piece.position
  end
  
  def piece_on_buoy?
    @game_piece.on_buoy?
  end

  def piece_on_board?
    @game_piece.on_board?
  end

  private
  def draw
    @deck.get_card
  end

  def move_piece(directions)
    @game_piece.move(directions)
    check_for_buoy
  end

  def follow_directions
    draw.directions
  end

  def check_for_buoy
    @buoys << piece_position if piece_on_buoy?
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

  def cards_count
    cards.count
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
    Coordinates.new(rand(-3...3), rand(-3...3))
  end
end


class Board
  attr_reader :width, :height

  def initialize(dimensions)
    @width = dimensions.x
    @height = dimensions.y
    @buoys = []
  end

  public
  def buoys
    number_buoys.times { @buoys << create_buoy_unless_exists } unless @buoys.any?
    @buoys
  end

  def on_board?(position)
    squares.include? position
  end

  private
  def num_squares
    height * width
  end

  def squares
    squares = []
    x_coords = (0...width).to_a
    y_coords = (0...height).to_a

    x_coords.each do |x|
      y_coords.each do |y|
        squares << Coordinates.new(x, y)
      end
    end
    squares
  end
  
  def number_buoys
    num_squares / 5
  end

  def create_buoy_unless_exists
    unless @buoys.include? new_buoy
      new_buoy
    else
      create_buoy_unless_exists
    end
  end

  def new_buoy
    Coordinates.new(rand(0...width), rand(0...height))
  end
end


class GamePiece
  attr_reader :position

  def initialize(board, starting_position)
    @board = board
    @position = starting_position
  end

  public
  def move(directions)
    update_position(directions)
  end

  def on_buoy?
    board_buoys.include? @position 
  end

  private
  def update_position(directions)
    move_to = new_position(directions)
    @position = move_to if on_board?(move_to)
  end

  def x_position
    @position.x
  end

  def y_position
    @position.y
  end

  def new_position(directions)
    Coordinates.new((x_position + directions.x), (y_position + directions.y))
  end

  def board_buoys
    @board.buoys
  end

  def on_board?(position)
    @board.on_board?(position)
  end
end
