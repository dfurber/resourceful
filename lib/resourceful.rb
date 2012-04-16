require "resourceful/version"

require 'inherited_resources'
require 'simple_form'
# require 'devise'
require 'has_scope'
require 'kaminari'
require 'slim'
require 'meta_search'
require 'andand'
require 'carrierwave'
# require 'sass-rails'
# require 'bootstrap-sass'
require 'jquery-rails'

module Resourceful
  # Your code goes here...
  class Engine < ::Rails::Engine
  end
  
  autoload :BaseMethods, 'resourceful/base_methods'
  autoload :FormApi, 'resourceful/form_api'
  autoload :CollectionTableApi, 'resourceful/collection_table_api'
  autoload :CollectionFilterApi, 'resourceful/collection_filter_api'
  autoload :MemberPageApi, 'resourceful/member_page_api'
  autoload :NestedForm, 'resourceful/nested_form'
  
  
end

class ActionController::Base
  
  def self.make_resourceful
    class_eval do

      inherit_resources  
      has_scope :sort, :only => :index, :using => [:c, :d]
      respond_to :html

      include Resourceful::BaseMethods
      include Resourceful::FormApi
      include Resourceful::CollectionTableApi
      include Resourceful::CollectionFilterApi
      include Resourceful::MemberPageApi
      
    end
    
  end
  
  
end

