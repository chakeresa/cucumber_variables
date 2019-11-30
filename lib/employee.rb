class Employee
  attr_accessor :name, :reports

  @@name = ''
  @@reports = [Employee.new]
  # Employee.class_variables => [:@@name, :@@reports]
  # Employee.class_variable_get(:@@reports)
  # Employee.class_variable_get(:"@@#{name_of_attr}")
end
