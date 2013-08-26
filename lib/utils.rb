class Utils
  class << self

    def is_a_number num
      begin
        Integer(num)
        true
      rescue
        false
      end
    end

    def is_an_operator operator_str
      ['+', '-', '*', '/'].include? operator_str
    end

  end
end