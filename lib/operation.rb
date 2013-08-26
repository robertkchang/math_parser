class Operation

  attr_accessor :operator, :operand1, :operand2, :ready

  def initialize
    @ready = false
  end

  def ready?
    @ready
  end

  def add_operand operand
    if !@operand1
      @operand1 = operand
    else
      @operand2 = operand
      @ready = true
    end
  end

  def do_expression
    return nil if @operator == nil || @operand1 == nil || @operand2 == nil

    puts "do_expression: #{@operator}, #{@operand1}, #{operand2}"

    operator = @operator
    operand1 = @operand1.to_f
    operand2 = @operand2.to_f

    result = nil
    case operator
      when '+'
        result = operand2 + operand1
      when '-'
        result = operand2 - operand1
      when '*'
        result = operand2 * operand1
      when '/'
        result = operand2 / operand1
    end

    if result
       result == result.to_i ? result.to_i : result
    end
  end

  def to_s
    "#{operand1} #{operator} #{operand2}"
  end

end