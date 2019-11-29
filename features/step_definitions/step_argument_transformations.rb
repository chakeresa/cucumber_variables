require './lib/employee'

Given(/the Employees?/) do |table|
# table.column_names => ["var", "Name"]
# table.hashes => [{"var"=>"E1", "name"=>"Bob"}]
  table.hashes.each do |hash|
    create_employee(hash)
  end
end

Then("'{expression}' has the value {string}") do |expression, expected_value|
  expect(expression.to_s).to eq(expected_value)
end
