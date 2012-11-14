module Resourceful::DraperMethods

  extend ActiveSupport::Concern

  included do

    def decorator_name
      "#{resource_class.to_s}Decorator"
    end

    def decorator
      @decorator ||= decorator_name.constantize
    end

    def decorator_exists?
      decorator_name.constantize rescue nil
    end

    def resource
      return get_resource_ivar if get_resource_ivar
      if decorator_exists?
        super
        set_resource_ivar decorator.decorate(get_resource_ivar)
      else
        super
      end
    end

    def decorated_collection
      return collection unless decorator_exists?
      @decorated_collection ||= collection.map { |item| decorator.decorate item }
    end
    helper_method :decorated_collection

  end


end