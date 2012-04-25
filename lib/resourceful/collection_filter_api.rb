module Resourceful
  
  module CollectionFilterApi
    
    extend ActiveSupport::Concern
    
    included do
      
      def filter_columns
        self.class.filter_columns
      end
      
      protected
      
      def self.filter(name, opts={})
        _resourceful_process_item(:filter_columns, name, opts)
      end
      
      def self.exclude_filter(name)
        _resourceful_exclude_item :filter_columns, name
      end
      
      class_attribute :filter_columns, instance_reader: true
      self.filter_columns = []
      
    end
    
  end
  
end