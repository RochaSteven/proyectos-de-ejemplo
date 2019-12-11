
require 'pry-byebug'

class Markdown
  attr_reader :data

  def initialize(filepath)
    @filepath = filepath
    @data = { title: 'No title',
              slides: [] }
  end

  def parse
    puts "[INFO] Parsing #{@filepath}"
    @lines = File.read(@filepath).split("\n")
    @lines.delete('')

    current = nil
    i = 0
    while (i<@lines.size)
      line = @lines[i]
      if line.start_with?('# ')
        @data[:title] = line.gsub('# ', '')
        i += 1
      elsif line.start_with?('## ')
        @data[:slides] << current if current
        current = { title: line.gsub('## ', '') }
        i += 1
      else
        i += 1
      end
    end
    @data[:slides] << current if current
    return @data
  end
end