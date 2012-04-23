module Resourceful
  module BaseMethods
    
    extend ActiveSupport::Concern
    included do
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

      class_eval do
        def self._resourceful_process_item(type, name, opts={})
          opts.symbolize_keys!
          opts[:name] = name
          if opts.key?(:prepend)
            send(type).unshift opts
          elsif opts.key?(:before) or opts.key?(:after)
            key = _get_index_for type, name
            if key
              send(type).insert opts, (opts.key?(:before) ? key-1 : key)
              return
            end
          end
          send(type) << opts
        end

        def self._resourceful_exclude_item(type, name)
          send "#{type}=", send(type).map {|value| value[:name] == name ? nil : value }.compact

        end

        def self._get_index_for(type, name)
          needle = nil
          self.send(type).each_with_index {|item, i| needle = i if item[:name] == name }
          needle
        end
      end

    end
    
    
  end
  
  
end