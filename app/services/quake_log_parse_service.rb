class QuakeLogParseService
  attr_accessor :file, :games

  def initialize(file)
    @file = file
    @games = []
  end

  def self.perform(file)
    new(file).perform
  end

  def perform
    parse_log
  end

  private

  def parse_log
    file.each_line do |line|
      if new_game?(line)
        games << Game.new(games.length+1)
        next
      elsif player?(line)
        player = Player.new(get_player_name(line))
        games.last.players << player unless games.last.players.select{|player| player.name == get_player_name(line)}.length >= 1
        next
      elsif kill?(line)
        games.last.increment_kill
        assassin = get_assassin(line)
        victim = get_victim(line)
        if games.last.types_of_death.select{ |death_type| death_type.name == cause_of_death(line)}.length >= 1
          games.last.types_of_death.find{ |type_of_death| type_of_death.name == cause_of_death(line)}.add_quantity
        else
          death_type = TypeOfDeath.new(cause_of_death(line))
          games.last.types_of_death << death_type
        end
        if assassin == "<world>"
          games.last.players.find{ |player| player.name == victim }.remove_kill
        else
          games.last.players.find{ |player| player.name == assassin }.add_kill
        end
      end
    end
    games
  end

  def new_game?(line)
    line.match(/InitGame/)
  end

  def player?(line)
    line.match(/(?:^|\W)ClientUserinfoChanged(?:$|\W)/) ? true : false
  end

  def kill?(line)
    line.match(/(?:^|\W)Kill(?:$|\W)/) ? true : false
  end

  def get_assassin(line)
    line.match(/([^:]+).(?=\skilled)/)[0].strip
  end

  def get_player_name(line)
    line.match(/((?<=n\\).*?(?=\\t))/)[0]
  end

  def get_victim(line)
    line.match(/((?<=killed\s).*(?=\sby))/)[0]
  end

  def cause_of_death(line)
    line.match(/((?<=by\s).*)/)[0]
  end

end