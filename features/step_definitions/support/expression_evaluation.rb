module ExpressionEvaluation
  def evaluate(expression)
    variable_name = @employees.keys.find do |key|
      expression.start_with?(key)
    end rescue nil

    if variable_name && variable_name != expression
      variable_value = @employees[variable_name]
      methods = expression.gsub(/^#{Regexp.quote(variable_name)}\.?/, '')
      variable_value.send(methods)
    else
      # eval(expression)
      expression
    end
  end
end

World ExpressionEvaluation
