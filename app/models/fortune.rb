class Fortune
  attr_reader :fortune, :options

  def initialize
    @fortune = ""
    @options = {}
  end

  def random
    fortune_by({})
  end

  def find_by(options)
    fortune_by(options)
  end

  private
  def fortune_by(options)
    params = "#{options[:database]}" if options[:database].present?
    output = `fortune #{params}` ; result = $?.success?
    output
  end
end