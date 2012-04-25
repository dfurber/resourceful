module Resourceful
  module CollectionSorting
    
    extend ActiveSupport::Concern
    included do
      
      class_attribute :default_sort_column, instance_reader: true
      class_attribute :default_sort_direction, instance_reader: true

      def self.set_default_sort_column(value)
        self.default_sort_column = value
      end
      
      def self.set_default_sort_direction(value)
        self.default_sort_direction = value
      end
      
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