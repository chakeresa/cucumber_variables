class Employee
  attr_accessor :name, :reports

  def initialize(options)
    @name = options[:name]
    @reports = []
  end
end
