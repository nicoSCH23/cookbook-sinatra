class Top

attr_reader :path, :title

  def initialize(attributes = {})
    @path = attributes[:path]
    @title = attributes[:title]
  end
end
