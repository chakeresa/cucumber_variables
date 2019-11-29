module ExpressionEvaluation
  def evaluate(expression)
    variable_name = @employees.keys.find do |key|
      expression.start_with?(key)
    end rescue nil

    if variable_name == expression
      @employees[variable_name]
    elsif variable_name != nil
      methods = expression.gsub(/^#{Regexp.quote(variable_name)}\.?/, '').split('.')
      chain = @employees[variable_name]

      methods.each do |method|
        chain = chain.send(method)
      end

      chain
    elsif expression == ''
      nil
    else
      # eval(expression)
      expression
    end
  end
end

World ExpressionEvaluation
