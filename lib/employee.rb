class Employee
  attr_accessor :name, :reports

  def initialize(options = {})
    @name = options[:name] || 'default employee name'
    @reports = options[:reports] || []
  end
end
