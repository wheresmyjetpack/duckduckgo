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
    Coordinates.new(rand(0...6), rand(0...6))
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
    x_coords = (0..width).to_a
    y_coords = (0..height).to_a

    x_coords.each do |x|
      y_coords.each do |y|
        squares << Coordinates.new(x, y)
      end
    end
    squares
  end
  
  def number_buoys
    num_squares / 4
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

  private
  def update_position(directions)
    move_horizontally(directions)
    move_vertically(directions)
    puts "Moving to #{@position}"
    puts "space not on board" unless on_board? 
    puts "Landed on a buoy!" if on_buoy?
  end

  def move_horizontally(directions)
    @position.x += directions.x
  end

  def move_vertically(directions)
    @position.y += directions.y
  end

  def on_buoy?
    board_buoys.include? @position 
  end

  def board_buoys
    @board.buoys
  end

  def on_board?
    @board.on_board?(@position)
  end
end
