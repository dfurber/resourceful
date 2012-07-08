require "resourceful/version"

require 'inherited_resources'
require 'simple_form'
require 'has_scope'
require 'kaminari'
require 'slim'
require 'meta_search'
require 'cells'

module Resourceful
  # Your code goes here...
  class Engine < ::Rails::Engine
  end
  
  autoload :BaseMethods, 'resourceful/base_methods'
  autoload :FormApi, 'resourceful/form_api'
  autoload :CollectionTableApi, 'resourceful/collection_table_api'
  autoload :CollectionFilterApi, 'resourceful/collection_filter_api'
  autoload :CollectionSorting, 'resourceful/collection_sorting'
  autoload :MemberPageApi, 'resourceful/member_page_api'
  autoload :NestedForm, 'resourceful/nested_form'
  
  autoload :Sorting, 'resourceful/sorting'
  autoload :SortableList, 'resourceful/sortable_list'
  autoload :ListBuilder, 'resourceful/list_builder'
  
  
end

class ActionController::Base
  
  def self.make_resourceful
    class_eval do

      inherit_resources  
      respond_to :html, :json

      include Resourceful::BaseMethods
      include Resourceful::FormApi
      include Resourceful::CollectionTableApi
      include Resourceful::CollectionFilterApi
      include Resourceful::CollectionSorting
      include Resourceful::MemberPageApi
      
    end
    
  end
  
  
end

def decorate_class_with(module_name)
  class_eval do
    extend module_name
  end
end



