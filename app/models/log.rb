class Log
  def initialize(log)
    File.open(Rails.root.join('log/', 'games.log'), 'wb') do |file|
      file.write(log.read)
    end
  end
end