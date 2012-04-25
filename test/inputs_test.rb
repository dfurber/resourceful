require 'test_helper'

class InputsTest < ActiveSupport::TestCase
  
  teardown do
    ApplicationController.reset_inputs
  end
  
  test "can add input to collection page" do
    ApplicationController.input :foo, label: 'Foolishness'
    cols = ApplicationController.inputs
    assert_equal 1, cols.size, 'The input did not get added to the inputs.'
    assert_equal :foo, cols.first[:name]
    assert_equal 'Foolishness', cols.first[:label]
  end
  
  test "can prepend a input" do
    ApplicationController.input :foo
    ApplicationController.input :bar, prepend: true    
    cols = ApplicationController.inputs
    assert_equal 2, cols.size, 'The input did not get added to the inputs.'
    assert_equal :bar, cols.first[:name]
  end
  
  test "can insert a input after another input" do
    ApplicationController.input :foo
    ApplicationController.input :bar
    ApplicationController.input :baz, after: :foo
    cols = ApplicationController.inputs
    assert_equal 3, cols.size, 'The input did not get added to the inputs.'
    assert_equal :baz, cols.second[:name]
  end

  test "can insert a input before another input" do
    ApplicationController.input :foo
    ApplicationController.input :bar
    ApplicationController.input :baz, before: :bar
    cols = ApplicationController.inputs
    assert_equal 3, cols.size, 'The input did not get added to the inputs.'
    assert_equal :baz, cols.second[:name]
  end
  
  test "can add a fieldset with a legend" do
    ApplicationController.fieldset :left do
      legend 'Test'
      input :foo
      input :bar
    end
    assert_equal :fieldset, ApplicationController.inputs.first[:as]
    fieldset = ApplicationController.inputs.first[:fieldset]
    assert_kind_of Resourceful::Fieldset, fieldset
    assert_equal :left, fieldset.side
    
    inputs = fieldset.inputs
    assert_equal 3, inputs.size
    assert_equal :legend, inputs.first[:as]
    assert_equal 'Test', inputs.first[:label]
  end
  
end
