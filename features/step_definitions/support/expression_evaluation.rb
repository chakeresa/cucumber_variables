module ExpressionEvaluation
  def evaluate(expression)
    variable_name = @variable_storage_hash.keys.find do |key|
      expression.start_with?(key)
    end rescue nil

    if variable_name == expression
      @variable_storage_hash[variable_name]
    elsif variable_name != nil
      methods_with_closing_bracket = expression
       .gsub(/^#{Regexp.quote(variable_name)}\.?/, '')
       .split(/\.|\[/)

      methods = methods_with_closing_bracket.map do |dirty_method|
        if dirty_method.end_with?(']')
          ['[]', dirty_method.gsub(']', '').to_i]
        else
          dirty_method
        end
      end

      chain = @variable_storage_hash[variable_name]

      methods.each do |method|
        chain = chain.send(*method)
      end

      chain
    elsif expression == ''
      nil
    else
      expression
    end
  end
end

World ExpressionEvaluation
