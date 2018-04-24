class Recipe

attr_reader :description, :name, :prep_time, :done, :difficulty, :picture_path

  def initialize(attributes = {})
    @name = attributes[:name]
    @description = attributes[:description]
    @prep_time = attributes[:prep_time]
    @done = attributes[:done] == "true"
    @picture_path = attributes[:picture_path] ? attributes[:picture_path] : 'base.png'
    @difficulty = attributes[:difficulty]
  end

  def mark_as_done!
    @done = true
  end
end
