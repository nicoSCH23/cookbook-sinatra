class Top

attr_reader :path, :name, :description, :prep_time, :difficulty, :picture_path

  def initialize(attributes = {})
    @path = attributes[:path]
    @name = attributes[:name]
    @description = attributes[:description]
    @prep_time = attributes[:prep_time]
    @picture_path = attributes[:picture_path] ? attributes[:picture_path] : 'base.png'
    @difficulty = attributes[:difficulty]
  end

end
