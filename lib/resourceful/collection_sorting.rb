module Resourceful
  module CollectionSorting
    
    extend ActiveSupport::Concern
    included do
      
      def self.default_sort_column(value)
        @default_sort_column_value = value
      end

      def self.default_sort_direction(value)
        @default_sort_direction_value = value
      end

      def self.default_sort_column_value
        @default_sort_column_value
      end

      def self.default_sort_direction_value
        @default_sort_direction_value
      end

      def default_sort_column; self.class.default_sort_column_value; end
      def default_sort_direction; self.class.default_sort_direction_value; end

      has_scope :sort_order, :only => :index, :using => [:c, :d], :default => {} do |controller, scoped, value| #, :default => [default_sort_column, default_sort_direction]
        if !value.first and !value.last
          value.first = controller.default_sort_column
          value.last  = controller.default_sort_direction
        end
        scoped.sort_order value.first, value.last
      end



      
    end
  end
end