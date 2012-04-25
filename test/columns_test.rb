require 'test_helper'

class ColumnsTest < ActiveSupport::TestCase
  
  teardown do
    ApplicationController.reset_columns
  end
  
  test "can add column to collection page" do
    ApplicationController.column :foo, label: 'Foolishness'
    cols = ApplicationController.columns
    assert_equal 1, cols.size, 'The column did not get added to the columns.'
    assert_equal :foo, cols.first[:name]
    assert_equal 'Foolishness', cols.first[:label]
  end
  
  test "can prepend a column" do
    ApplicationController.column :foo
    ApplicationController.column :bar, prepend: true    
    cols = ApplicationController.columns
    assert_equal 2, cols.size, 'The column did not get added to the columns.'
    assert_equal :bar, cols.first[:name]
  end
  
  test "can insert a column after another column" do
    ApplicationController.column :foo
    ApplicationController.column :bar
    ApplicationController.column :baz, after: :foo
    cols = ApplicationController.columns
    assert_equal 3, cols.size, 'The column did not get added to the columns.'
    assert_equal :baz, cols.second[:name]
  end

  test "can insert a column before another column" do
    ApplicationController.column :foo
    ApplicationController.column :bar
    ApplicationController.column :baz, before: :bar
    cols = ApplicationController.columns
    assert_equal 3, cols.size, 'The column did not get added to the columns.'
    assert_equal :baz, cols.second[:name]
  end
  
end
