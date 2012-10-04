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

    def collection
      return get_collection_ivar if get_collection_ivar
      items = end_of_association_chain.search(params[:search]).relation
      get_collection_ivar = if decorator_exists?
        items.map { |item| decorator.decorate item }
      else
        items
      end
    end

  end


end