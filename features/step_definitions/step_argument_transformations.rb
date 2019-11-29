require './lib/employee'

Given("the Employee") do |table|
# table.column_names => ["var", "Name"]
# table.hashes => [{"var"=>"E1", "name"=>"Bob"}]
  table.hashes.each do |hash|
    variable_name = hash["var"]
    employee_name = evaluate(hash["name"])

    new_employee = Employee.new(name: employee_name)
    expect(new_employee).to be_an(Employee)
    expect(new_employee.name).to eq(employee_name)

    @employees = Hash.new if @employees.class != Hash
    @employees[variable_name] = new_employee
  end
end

Then("'{expression}' has the value {string}") do |expression, expected_value|
  expect(expression.to_s).to eq(expected_value)
end
