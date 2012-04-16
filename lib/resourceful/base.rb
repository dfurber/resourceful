module Resourceful
  class Base < ::ApplicationController
    
    def self.make_resourceful(base)
      base.class_eval do

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
  
  make_resourceful(self)
  
end