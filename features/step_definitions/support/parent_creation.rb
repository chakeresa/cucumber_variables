module ParentCreation
  def create_parent(klass, table_hash)
    variable_name = table_hash.delete('var')
    # TODO: handle all table inputs iteratively
    new_parent = klass.new

    table_hash.each do |header, text|
      begin
        default_attr = klass.class_variable_get(:"@@#{header}")
      rescue NameError
        default_attr = nil # TODO: or keep error?
      end

      case default_attr.class.to_s
      when 'String'
        parent_attr = evaluate(table_hash[header])
        new_parent.send(:"#{header}=", parent_attr)
      when 'Array'
        # TODO: bring in child input stuff
      else
        # TODO: throw error?
      end
    end

    children_input_text = table_hash['reports']
    new_parent.reports = create_children(Employee, children_input_text)

    verify_class(new_parent, klass)
    save_to_variable(new_parent, variable_name) if variable_name

    new_parent
  end

  # TODO: move to ExpressionEvaluation
  def create_children(klass, input_text)
    if input_text == '' || input_text.nil?
      []
    else
      begin
        children = JSON.parse(input_text).map do |attr_hash|
          create_parent(klass, attr_hash)
        end
      rescue JSON::ParserError
        children = input_text.gsub(' ', '').split(',').map do |var_in_table|
          evaluate(var_in_table)
        end
      end
      
      children.each do |child_object|
        verify_class(child_object, klass)
      end
    end
  end

  def verify_class(object, klass)
    expect(object).to be_a(klass)
  end

  def save_to_variable(object, variable_name)
    @variable_storage_hash = Hash.new if @variable_storage_hash.class != Hash
    @variable_storage_hash[variable_name] = object
  end
end

World ParentCreation