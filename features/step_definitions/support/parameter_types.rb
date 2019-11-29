ParameterType(
  name: 'expression',
  regexp: /.+/,
  transformer: -> (expression) { evaluate(expression) }
)