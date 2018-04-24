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

  private

  def save_to_csv
    CSV.open(@csv_file, 'w') do |csv|
      @tops.each do |top|
        csv.puts([top.title, top.path])
      end
    end
  end

  def load_csv
    return unless File.exist?(@csv_file)

    CSV.foreach(@csv_file) do |row|
      attributes = {
        title: row[0],
        path: row[1],
      }
      @tops << Top.new(attributes)
    end
  end
end

