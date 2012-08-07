module Resourceful
  module BaseMethods
    
    extend ActiveSupport::Concern
    included do

      decorate_class_with ListBuilder
      
      def index_title
        controller_name.titleize
      end

      def edit_title
        "Edit #{show_title}"
      end

      def new_title
        "Add New #{controller_name.singularize.titleize}"
      end

      def show_title
        resource.respond_to?(:name) ? resource.name : controller_name.singularize.titleize
      end
      
      # Stubbed implementation - you should override with your own authorization logic.
      def can_create?(item=nil)
        methods.include?(:create)
      end
      
      def can_update?(item=nil)
        methods.include?(:update)
      end
      
      def can_show?(item=nil)
        methods.include?(:show) and resource.persisted?
      end
      
      def can_destroy?(item=nil)
        resource.persisted? and methods.include?(:destroy)
      end
      
      def has_index_page?
        methods.include?(:index) and not is_singleton
      end

      def resource_form_target
        resource
      end

      def has_tabs?
        tabs_to_show.present?
      end

      def default_sort_column
        'name'
      end
    
      def default_sort_direction
        'asc'
      end
    
      def resource_form_arguments
        {}
      end

      def collection
        get_collection_ivar ||= end_of_association_chain.search(params[:search]).relation
      end

      def scenario
      end
    
      def resource_params
        p = super
        p == [{}] ? {} : p
      end

      def build_resource 
        if scenario.present?
          get_resource_ivar || set_resource_ivar(end_of_association_chain.send(method_for_build, resource_params, :as => scenario))
        else
          super
        end
      end

      def update_resource(object, attributes)
        if scenario.present?
          object.update_attributes(attributes, :as => scenario)
        else
          super
        end
      end

      def is_singleton
        resources_configuration[:self][:singleton]
      end    
      
      def parent_name
        parent.andand.name || 'Parent'
      end
      helper_method :parent_name

    end
  end
  
  
end