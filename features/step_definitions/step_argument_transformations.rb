require './lib/employee'

Given("the Employee") do |table|
# table.column_names => ["var", "Name"]
# table.hashes => [{"var"=>"E1", "name"=>"Bob"}]
  table.hashes.each do |hash|
    variable_name = hash["var"]
    employee_name = hash["name"]

    new_employee = Employee.new(name: employee_name)
    expect(new_employee).to be_an(Employee)
    expect(new_employee.name).to eq(employee_name)

    @employees = Hash.new if @employees.class != Hash
    @employees[variable_name] = new_employee
  end
end

Then("{string} has the value {string}") do |expression, expected_value|
  variable_name = @employees.keys.find do |key|
    expression.start_with?(key)
  end

  actual_value = if variable_name && variable_name != expression
    variable_value = @employees[variable_name]
    methods = expression.gsub(/^#{Regexp.quote(variable_name)}\.?/, '')
    variable_value.send(methods)
  else
    eval(expression)
  end

  expect(actual_value).to eq(expected_value)
end
