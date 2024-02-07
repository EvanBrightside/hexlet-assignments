# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/stack'

class StackTest < Minitest::Test
  def setup
    @obj = Stack.new
  end

  def test_add_element
    assert_equal @obj.push!(1), [1]
  end

  def test_remove_element
    @obj.push!(1)
    assert_equal @obj.pop!, 1
  end

  def test_clear_stack
    @obj.push!(1)
    @obj.clear!
    assert @obj.empty?
  end

  def test_empty
    assert @obj.empty?
  end
end

test_methods = StackTest.new({}).methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has not tests!' if test_methods.empty?
