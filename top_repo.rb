require 'csv'
require_relative 'top'
require_relative 'parsing'

class TopRepo # Repository, Fake Database
  def initialize(csv_file)
    @tops = []
    @csv_file = csv_file
    load_csv
  end

  def all
    @tops
  end

  def top_five
    @tops.last(5)
  end

  def add_top(top)
    @tops << top
    save_to_csv
  end

  def save_to_csv
    CSV.open(@csv_file, 'w', write_headers: true, headers: ["name", "path", "description", "difficulty", "prep_time", "picture_path"]) do |csv|
      @tops.each do |top|
        csv.puts([top.name, top.path, top.description, top.difficulty, top.prep_time, top.picture_path])
      end
    end
  end


  def load_csv
    return unless File.exist?(@csv_file)

    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file, csv_options) do |row|
      row[:name] = row[:name]
      row[:path] = row[:path]
      row[:description] = row[:description]
      row[:difficulty] = row[:difficulty]
      row[:prep_time] = row[:prep_time]
      row[:picture_path] = row[:picture_path]
      @tops << Top.new(row)
    end
  end
end
