require "spec_helper"
require 'operation'

describe "Do Expression" do

  it "should do ['+', 3, 2] correctly to 5" do
    op = Operation.new
    op.operator = '+'
    op.operand1 = 3
    op.operand2 = 2
    op.do_expression.should eql 5
  end

  it "should do ['-', 3, 2] correctly to 5" do
    op = Operation.new
    op.operator = '-'
    op.operand1 = 2
    op.operand2 = 3
    op.do_expression.should eql 1
  end

  it "should do ['*', 3, 2] correctly to 5" do
    op = Operation.new
    op.operator = '*'
    op.operand1 = 2
    op.operand2 = 3
    op.do_expression.should eql 6
  end

  it "should do ['/', 2, 4] correctly to 5" do
    op = Operation.new
    op.operator = '/'
    op.operand1 = 2
    op.operand2 = 4
    op.do_expression.should eql 2
  end

end