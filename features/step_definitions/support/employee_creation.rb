module EmployeeCreation
  def create_employee(hash)
    variable_name = hash['var']
    employee_name = evaluate(hash['name'])
    reports_input = hash['reports']

    new_employee = Employee.new(
      name: employee_name,
      reports: employee_reports(reports_input)
    )

    verify_employee(new_employee)
    save_employee_to_variable(new_employee, variable_name) if variable_name

    new_employee
  end

  def employee_reports(reports_input)
    if reports_input == '' || reports_input.nil?
      nil
    else
      begin
        reports = JSON.parse(reports_input).map do |attr_hash|
          create_employee(attr_hash)
        end
      rescue JSON::ParserError
        reports = reports_input.gsub(' ', '').split(',').map do |var_in_table|
          evaluate(var_in_table)
        end
      end
      
      reports.each do |report|
        verify_employee(report)
      end
    end
  end

  def verify_employee(employee)
    expect(employee).to be_an(Employee)
  end

  def save_employee_to_variable(employee, variable_name)
    @employees = Hash.new if @employees.class != Hash
    @employees[variable_name] = employee
  end
end

World EmployeeCreation