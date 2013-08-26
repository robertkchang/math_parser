require_relative 'utils'
require_relative 'operation'

class MathParser
  class << self

    # returns postfix of infix expression
    def parse in_fix

      expr_arr = in_fix.to_s.gsub(/\s+/, '').split(%r{\s*})

      postfix_arr = []
      operator_arr = []
      higher_precedence = false
      higher_precedence_cnt = 0

      expr_idx = 0
      while expr_idx < expr_arr.size
        token = expr_arr[expr_idx]
        case token
          when '+',  '-'
            operator_arr << token
          when '*' , '/'
            operator_arr << token
            higher_precedence = true
            higher_precedence_cnt += 1
          when '('
            # extract nested expression
            open_paren_cnt = 1
            nested_infix = []
            until open_paren_cnt == 0
              expr_idx += 1
              nested_token = expr_arr[expr_idx]
              if nested_token == '('
                open_paren_cnt += 1
              elsif nested_token == ')'
                open_paren_cnt -= 1
              end
              nested_infix << nested_token unless nested_token == ')' && open_paren_cnt == 0
            end

            # recursively call parse
            nested_postfix = parse nested_infix.join
            postfix_arr << nested_postfix

            if nested_postfix.to_s.index(/[*\/]/) && nested_postfix.length == 3 # simple nested - e.g. *43
              higher_precedence = true
              higher_precedence_cnt += 1
            end

            if higher_precedence
              postfix_arr << operator_arr.pop
              higher_precedence = false
              pop_operator_if_two_higher_precedence higher_precedence_cnt, postfix_arr, operator_arr
            end

          else
            if Utils.is_a_number token
              postfix_arr << token
            else
              raise "Invalid number: #{token}."
            end

            if higher_precedence
              postfix_arr << operator_arr.pop
              higher_precedence = false
              pop_operator_if_two_higher_precedence higher_precedence_cnt, postfix_arr, operator_arr
            end
        end
        expr_idx+=1
      end

      operator_arr.each {|operator| postfix_arr << operator}
      postfix_arr.join
    end

    def pop_operator_if_two_higher_precedence higher_precedence_cnt, postfix_arr, operator_arr
      if higher_precedence_cnt > 1
        postfix_arr << operator_arr.pop
      end
    end

    # calculates the postfix expression
    def calculate post_fix
      post_arr = post_fix.to_s.split(%r{\s*})

      pending_ops_arr = []
      ready_values = []

      until post_arr.length == 0
        token = post_arr.pop
        if Utils.is_an_operator(token)
          op = Operation.new
          op.operator = token
          pending_ops_arr << op
        else
          ready_values << apply_operand_to_last_pending(pending_ops_arr, token)
        end
      end

      until pending_ops_arr.length == 0
        pending = pending_ops_arr.pop
        until pending.ready?
          if ready_values.length > 0
            pending.add_operand ready_values.pop
            if pending.ready?
              ready_values << pending.do_expression
            end
          else
            break
          end
        end
      end

      if pending_ops_arr.length != 0
        raise "There are #{pending_ops_arr.length} pending operations left"
      end

      if ready_values.length == 0
        raise "No result"
      end

      puts ready_values.last
      ready_values.last
    end

    def apply_operand_to_last_pending pending_ops_arr, operand
      last_pending_op = pending_ops_arr.last
      if last_pending_op
        if !last_pending_op.ready?
          last_pending_op.add_operand operand
        end

        if last_pending_op.ready?
          pending_ops_arr.pop
          resolved_val = last_pending_op.do_expression
          apply_operand_to_last_pending pending_ops_arr, resolved_val
        end
      else
        operand
      end
    end

    ## calculates the postfix expression
    #def calculate post_fix
    #  post_arr = post_fix.to_s.split(%r{\s*})
    #
    #  pending_ops_arr = []
    #  ready_ops_arr = []
    #
    #  until post_arr.length == 0
    #    token = post_arr.pop
    #    if Utils.is_an_operator(token)
    #      op = Operation.new
    #      op.operator = token
    #      pending_ops_arr << op
    #    else
    #      last_pending_op = pending_ops_arr.last
    #      if !last_pending_op.ready?
    #        last_pending_op.add_operand token
    #      end
    #      if last_pending_op.ready?
    #        ready_ops_arr << pending_ops_arr.pop
    #      end
    #    end
    #  end
    #
    #  ready_values = []
    #  until ready_ops_arr.length == 0
    #    ready = ready_ops_arr.pop
    #    ready_values << ready.do_expression
    #  end
    #
    #  until pending_ops_arr.length == 0
    #    pending = pending_ops_arr.pop
    #    until pending.ready?
    #      if ready_values.length > 0
    #        pending.add_operand ready_values.pop
    #        if pending.ready?
    #          ready_values << pending.do_expression
    #        end
    #      else
    #        break
    #      end
    #    end
    #  end
    #
    #  if pending_ops_arr.length != 0
    #    raise "There are #{pending_ops_arr.length} pending operations left"
    #  end
    #
    #  if ready_values.length == 0
    #    raise "No result"
    #  end
    #
    #  puts ready_values.last
    #  ready_values.last
    #end

    # parse and calculates the given expression
    def evaluate in_str
      calculate parse in_str
    end
  end


end