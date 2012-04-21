module Resourceful
  
  module Sorting
    extend ActiveSupport::Concern
    included do

      scope :sort_order, lambda {|c, d| 
        qry = self.custom_sort_columns c, d
        qry || order("#{(c || default_sort_column).gsub(/[\s;'\"]/,'')} #{d == 'down' ? 'DESC' : 'ASC'}")
      }

      def self.custom_sort_columns(c,d)
      end

      def default_sort_column
        self.class.default_sort_column || 'name'
      end

    end

  end
  
end