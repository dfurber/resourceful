module Resourceful
  class Base < ::ApplicationController
    
  #   def self.make_resourceful(base)
  #     base.class_eval do
  # 
  #       inherit_resources  
  #       respond_to :html
  # 
  #       include Resourceful::BaseMethods
  #       include Resourceful::FormApi
  #       include Resourceful::CollectionTableApi
  #       include Resourceful::CollectionFilterApi
  #       include Resourceful::CollectionSorting
  #       include Resourceful::MemberPageApi
  #       
  #     end
  #   end
  #   
  # end
  
  make_resourceful
  
end