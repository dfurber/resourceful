module Resourceful
  
  module CollectionFilterApi
    
    extend ActiveSupport::Concern
    
    included do
      
      @filter_columns = []
      def filter_columns; self.class.filter_columns || []; end

      protected
      
      def self.filter_columns; @filter_columns; end

      def self.filter(name, opts={})
        @filter_columns = _resourceful_process_item(@filter_columns, name, opts)
      end
      
      def self.exclude_filter(name)
        @filter_columns = _resourceful_exclude_item @filter_columns, name
      end
      
      
    end
    
  end
  
end