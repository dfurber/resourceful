require 'test_helper'

class FiltersTest < ActiveSupport::TestCase
  
  teardown do
    ApplicationController.reset_filters
  end
  
  test "can add filter to collection page" do
    ApplicationController.filter :foo, label: 'Foolishness'
    cols = ApplicationController.filter_columns
    assert_equal 1, cols.size, 'The filter did not get added to the filters.'
    assert_equal :foo, cols.first[:name]
    assert_equal 'Foolishness', cols.first[:label]
  end
  
  test "can prepend a filter" do
    ApplicationController.filter :foo
    ApplicationController.filter :bar, prepend: true    
    cols = ApplicationController.filter_columns
    assert_equal 2, cols.size, 'The filter did not get added to the filters.'
    assert_equal :bar, cols.first[:name]
  end
  
  test "can insert a filter after another filter" do
    ApplicationController.filter :foo
    ApplicationController.filter :bar
    ApplicationController.filter :baz, after: :foo
    cols = ApplicationController.filter_columns
    assert_equal 3, cols.size, 'The filter did not get added to the filters.'
    assert_equal :baz, cols.second[:name]
  end

  test "can insert a filter before another filter" do
    ApplicationController.filter :foo
    ApplicationController.filter :bar
    ApplicationController.filter :baz, before: :bar
    cols = ApplicationController.filter_columns
    assert_equal 3, cols.size, 'The filter did not get added to the filters.'
    assert_equal :baz, cols.second[:name]
  end
  
end
