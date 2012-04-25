require 'test_helper'

class SortsTest < ActiveSupport::TestCase
  
  teardown do
    ApplicationController.reset_sorts
  end
  
  test "can set sort column" do
    ApplicationController.set_default_sort_column 'foo'
    assert_equal 'foo', ApplicationController.default_sort_column
  end

  test "can set sort direction" do
    ApplicationController.set_default_sort_direction "up"
    assert_equal 'up', ApplicationController.default_sort_direction
  end
  
end
