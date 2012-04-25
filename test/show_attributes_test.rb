require 'test_helper'

class ShowAttributesTest < ActiveSupport::TestCase
  
  teardown do
    ApplicationController.reset_attributes_to_show
  end
  
  test "can add attributes_to_show to collection page" do
    ApplicationController.show :foo, label: 'Foolishness'
    cols = ApplicationController.attributes_to_show
    assert_equal 1, cols.size, 'The attributes_to_show did not get added to the attributes_to_shows.'
    assert_equal :foo, cols.first[:name]
    assert_equal 'Foolishness', cols.first[:label]
  end
  
  test "can prepend a attributes_to_show" do
    ApplicationController.show :foo
    ApplicationController.show :bar, prepend: true    
    cols = ApplicationController.attributes_to_show
    assert_equal 2, cols.size, 'The attributes_to_show did not get added to the attributes_to_shows.'
    assert_equal :bar, cols.first[:name]
  end
  
  test "can insert a attributes_to_show after another attributes_to_show" do
    ApplicationController.show :foo
    ApplicationController.show :bar
    ApplicationController.show :baz, after: :foo
    cols = ApplicationController.attributes_to_show
    assert_equal 3, cols.size, 'The attributes_to_show did not get added to the attributes_to_shows.'
    assert_equal :baz, cols.second[:name]
  end

  test "can insert a attributes_to_show before another attributes_to_show" do
    ApplicationController.show :foo
    ApplicationController.show :bar
    ApplicationController.show :baz, before: :bar
    cols = ApplicationController.attributes_to_show
    assert_equal 3, cols.size, 'The attributes_to_show did not get added to the attributes_to_shows.'
    assert_equal :baz, cols.second[:name]
  end
  
end
