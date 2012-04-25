module Resourceful
  
  module CollectionTableApi
    
    extend ActiveSupport::Concern
    
    included do
      
      @columns = []
      def self.columns
        @columns
      end
      def columns
        self.class.columns || {}
      end

      protected
      
      def self.column(name, opts={})
        @columns = _resourceful_process_item(@columns, name, opts)
      end
      
      def self.exclude_column(name)
        @columns = _resourceful_exclude_item @columns, name
      end

      
    end
    
  end
  
end