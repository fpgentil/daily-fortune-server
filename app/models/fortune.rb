class Fortune
  attr_reader :fortune

  def random
    random_fortune
  end

  def find_by(options)
    '== pending'
  end

  private
  def random_fortune
    %x['fortune']
  end
end