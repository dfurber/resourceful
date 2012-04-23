module Resourceful
  
  module CollectionTableApi
    
    extend ActiveSupport::Concern
    
    included do
      
      def columns;                    self.class.columns || []; end
      
      protected
      
      def self.column(name, opts={})
        _resourceful_process_item(:columns, name, opts)
      end
      
      def self.exclude_column(name)
        _resourceful_exclude_item :columns, name
      end

      class_attribute :columns
      self.columns = []
      
    end
    
  end
  
end