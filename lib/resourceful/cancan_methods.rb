module Resourceful
  module CanCanMethods
    extend ActiveSupport::Concern
    
    included do

      alias_method_chain :can_create?, :cancan
      alias_method_chain :can_update?, :cancan
      alias_method_chain :can_show?, :cancan
      alias_method_chain :can_destroy?, :cancan

    end
    
    def can_create_with_cancan?(item=nil)
      can_create_without_cancan?(item) and can?(:create, self.resource_class)
    end
    
    def can_update_with_cancan?(item=nil)
      can_update_without_cancan?(item) and can?(:update, item || resource)
    end
    
    def can_show_with_cancan?(item=nil)
      can_show_without_cancan?(item) and can?(:read, item || resource)
    end
    
    def can_destroy_with_cancan?(item=nil)
      can_destroy_without_cancan?(item) and can?(:destroy, item || resource)
    end

    
    
    
  end
end