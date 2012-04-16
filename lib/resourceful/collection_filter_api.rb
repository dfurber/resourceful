module Resourceful
  
  module CollectionFilterApi
    
    extend ActiveSupport::Concern
    
    included do
      
      def filter_columns;             self.class.filter_columns || []; end
      
      protected
      
      def self.filter(name, opts={})
        opts.symbolize_keys!
        opts[:name] = name
        @filter_columns ||= []
        @filter_columns << opts
      end

      def self.filter_columns;        @filter_columns; end
      
      @filter_columns = []
      
    end
    
  end
  
end