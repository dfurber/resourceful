module Resourceful
  module BaseMethods
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

    def collection
      get_collection_ivar ||= end_of_association_chain.search(params[:search]).relation
    end

    def scenario
    end
    
    def resource_params
      super.first
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

  end
end