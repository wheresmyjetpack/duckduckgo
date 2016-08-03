class Player
  attr_reader :name

  def initialize(name, duck)
    @name = name
    @duck = duck
  end
end

class Deck
    def initialize
    end
end

class Tub
end

class Duck
  attr_accessor :position

  def initialize
  end
end
