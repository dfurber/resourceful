# Allow cancan to pick up inherited resources configuration
module CanCan
  class ControllerResource
    
    def resource_class
      @controller.send :resource_class
    end
    
  end
end