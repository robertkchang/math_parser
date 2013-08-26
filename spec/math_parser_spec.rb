require "spec_helper"
require 'math_parser'

describe "Parse" do

  it "should parse correctly into postfix 3 + 4 * 5" do
    MathParser.parse("3 + (4 * 5)").should eql "345*+"
  end

  it "should parse correctly into postfix (3 + 4) * 5" do
    MathParser.parse("(3 + 4) * 5").should eql "34+5*"
  end

  it "should parse correctly into postfix 3 + (4 * 5)" do
    MathParser.parse("3 + (4 * 5)").should eql "345*+"
  end

  it "should parse correctly into postfix 3 * (4 + 5)" do
    MathParser.parse("3 * (4 + 5)").should eql "345+*"
  end

  it "should parse correctly into postfix 4 * 3 / 5 + 2" do
    MathParser.parse("4 * 3 / 5 + 2").should eql "43*5/2+"
  end

  it "should parse correctly into postfix 4 + 3 + 5 * 2" do
    MathParser.parse("4 + 3 + 5 * 2").should eql "4352*++"
  end

  it "should parse correctly into postfix 4 + 3 / 5 * 2" do
    MathParser.parse("4 + 3 / 5 * 2").should eql "435/2*+"
  end

  it "should parse correctly into postfix 4 * 3 + 5 * 2" do
    MathParser.parse("4 * 3 + 5 * 2").should eql "43*52*+"
  end

  it "should parse correctly into postfix 3 + 4 * 5 - 6 / 3 + 2" do
    MathParser.parse("3 + 4 * 5 - 6 / 3 + 2").should eql "345*63/-2++"
  end

  it "should parse correctly into postfix 3 + (4 * 5) - (4 / 2) + 6" do
    MathParser.parse("3 + (4 * 5) - (4 / 2) + 6").should eql "345*+42/-6+"
  end

  it "should parse correctly into postfix 2 + (3 * (4 + 5) + 2) / 2" do
    MathParser.parse("2 + (3 * (4 + 5) + 2) / 2").should eql "2345+*2+2/+"
  end

end

describe "Evaluate" do

  it "should evaluate correctly 3 + (4 * 5)" do
    MathParser.evaluate("3 + (4 * 5)").should eql 23
  end

  it "should evaluate correctly (3 + 4) * 5" do
    MathParser.evaluate("(3 + 4) * 5").should eql 35
  end

  it "should evaluate correctly 4 * 3 / 5 + 2" do
    MathParser.evaluate("4 * 3 / 5 + 2").should eql 4.4
  end

  it "should evaluate correctly 4 + 3 + 5 * 2" do
    MathParser.evaluate("4 + 3 + 5 * 2").should eql 17
  end

  it "should evaluate correctly 4 + 3 / 5 * 2" do
    MathParser.evaluate("4 + 3 / 5 * 2").should eql 5.2
  end

  it "should evaluate correctly 4 * 3 + 5 * 2" do
    MathParser.evaluate("4 * 3 + 5 * 2").should eql 22
  end

  it "should evaluate correctly 3 + 4 * 5 - 6 / 3 + 2" do
    MathParser.evaluate("3 + 4 * 5 - 6 / 3 + 2").should eql 23
  end

  it "should evaluate correctly 3 + (4 * 5) - (4 / 2) + 6" do
    MathParser.evaluate("3 + (4 * 5) - (4 / 2) + 6").should eql 27
  end

  it "should evaluate correctly 3 + 4 * 5 - 6 / 3 + 4 / 2 + 2" do
    MathParser.evaluate("3 + 4 * 5 - 6 / 3 + 4 / 2 + 2").should eql 25
  end

  it "should evaluate correctly 2 + (3 * (4 + 5) + 2) / 2" do
    MathParser.evaluate("2 + (3 * (4 + 5) + 2) / 2").should eql 16.5
  end

  #it "should evaluate correctly 10 + 2" do
  #  MathParser.evaluate("10 + 2").should eql 12
  #end

end