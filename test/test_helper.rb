# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
if ActiveSupport::TestCase.method_defined?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
end

ApplicationController.class_eval do
  def self.reset_columns
    @columns = []
  end
  
  def self.reset_filters
    @filter_columns = []
  end
  
  def self.reset_inputs
    @inputs = []
  end
  
  def self.reset_sorts
    @default_sort_column = nil
    @default_sort_direction = nil
  end
  
  def self.reset_attributes_to_show
    @attributes_to_show = nil
  end
  
end
