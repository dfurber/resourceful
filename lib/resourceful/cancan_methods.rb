module Resourceful
  module CanCanMethods
    extend ActiveSupport::Concern
    
    included do
      load_and_authorize_resource
    end
    
    # Stubbed implementation - you should override with your own authorization logic.
    def can_create?(item=nil)
      can :create, item || resource
    end
    
    def can_update?(item=nil)
      can :update, item || resource
    end
    
    def can_show?(item=nil)
      can :read, item || resource
    end
    
    def can_destroy?(item=nil)
      can :destroy, item || resource
    end

    
    
  end
end