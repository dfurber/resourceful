module Resourceful
  
  module CollectionTableApi
    
    extend ActiveSupport::Concern
    
    included do
      
      def columns;                    self.class.columns || []; end
      
      protected
      
      def self.column(name, opts={})
        opts.symbolize_keys!
        opts[:name] = name
        @columns ||= []
        @columns << opts
      end

      def self.columns;               @columns; end
      
      @columns = []
      
    end
    
  end
  
end