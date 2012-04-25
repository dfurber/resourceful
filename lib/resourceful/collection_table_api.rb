module Resourceful
  
  module CollectionTableApi
    
    extend ActiveSupport::Concern
    
    included do
      
      class_attribute :columns, instance_reader: true
      self.columns = []

      protected
      
      def self.column(name, opts={})
        _resourceful_process_item(:columns, name, opts)
      end
      
      def self.exclude_column(name)
        _resourceful_exclude_item :columns, name
      end

      
    end
    
  end
  
end