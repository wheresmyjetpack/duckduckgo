Coordinates = Struct.new(:x, :y)

class Player
  attr_reader :name, :objectives, :game_piece

  def initialize(args)
    @name = args[:name] || 'Sally Roe'
    @game_piece = args[:game_piece]
    @deck = args[:deck]
    @objectives = []
  end

  public
  def take_turn
    move_piece(follow_directions)
  end

  def get_position(item)
    item.position
  end
  
  def piece_on_objective?
    @game_piece.on_objective?
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
    check_for_objective
  end

  def follow_directions
    draw.directions
  end

  def check_for_objective
    @objectives << piece_position if piece_on_objective?
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
    directions = Coordinates.new(rand(-4...4), rand(-4...4))
    unless directions.x == 0 && directions.y == 0
      directions
    else
      create_directions
    end
  end
end


class Board
  attr_reader :width, :height

  def initialize(dimensions)
    @width = dimensions.x
    @height = dimensions.y
    @objectives = []
  end

  public
  def objectives
    if @objectives.empty?
      number_objectives.times do 
        @objectives << create_objective
        #puts @objectives
      end
    end
   @objectives
  end

  def on_board?(position)
    grid.include? position
  end

  private
  def area
    height * width
  end

  def grid
    grid = []

    (0..width).each do |x|
      (0..height).each do |y|
        grid << Coordinates.new(x, y)
      end
    end
    grid
  end
  
  def number_objectives
    puts (( height + width ) / 2) / 2
    (( height + width ) / 2) / 2
  end

  def create_objective
    unless @objectives.include? new_objective
      new_objective
    else
      create_objective
    end
  end

  def new_objective
    Coordinates.new(rand( 0...width ), rand( 0...height ))
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

  def on_objective?
    board_objectives.include? @position 
  end

  private
  def update_position(directions)
    move_to = new_position(directions)
    puts "Directions #{directions}"
    puts "New position #{move_to}"
    @position = move_to if on_board?(move_to)
  end

  def x_position
    @position.x
  end

  def y_position
    @position.y
  end

  def new_position(directions)
    x = x_position + directions.x
    y = y_position + directions.y

    x = @board.width if x > @board.width
    x = 0 if x < 0
   
    y = @board.height if y > @board.height
    y = 0 if y < 0

    Coordinates.new(x, y)
  end

  def board_objectives
    @board.objectives
  end

  def on_board?(position)
    @board.on_board?(position)
  end
end
