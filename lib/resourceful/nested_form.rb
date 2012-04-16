module Resourceful
  
  class NestedForm
  
    include Resourceful::FormApi
    include Resourceful::MemberPageApi
  
    def class_name
      'nested-form-item'
    end
  
    def title
      'Untitled'
    end
  
    def show_blank?
      false
    end
  
    def allow_destroy?
      true
    end
  
    def add_child_link_text
      'Add Item'
    end
  
    def remove_label
      'Remove'
    end
  
    # short or full 
    # (short is like a one line summary for each item in the collection)
    # (full would output a table for each attribute rendered using resource_details)
    def show_style
      :short
    end
  
    def show_title
      title
    end
    
  end

end