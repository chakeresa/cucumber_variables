module ParentCreation
  def create_parent(klass, table_hash)
    variable_name = table_hash.delete('var')
    # TODO: handle all table inputs iteratively
    parent_name = evaluate(table_hash['name'])
    children_input_text = table_hash['reports']

    new_parent = klass.new
    new_parent.name = parent_name
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