require "spec_helper"
require 'utils'

describe "#is_an_operator" do
  it "should return true if operator string is +" do
    Utils.is_an_operator('+').should be_true
  end

  it "should return true if operator string is -" do
    Utils.is_an_operator('-').should be_true
  end

  it "should return true if operator string is *" do
    Utils.is_an_operator('*').should be_true
  end

  it "should return true if operator string is /" do
    Utils.is_an_operator('/').should be_true
  end
end

