require './lib/employee'

Given(/the Employees?/) do |table|
  table.hashes.each do |hash|
    create_parent(Employee, hash)
  end
end

Then("'{expression}' has the value {string}") do |expression, expected_value|
  expect(expression.to_s).to eq(expected_value)
end
