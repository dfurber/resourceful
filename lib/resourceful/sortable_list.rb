module Resourceful
  
  module SortableList
    extend ActiveSupport::Concern
    included do

      acts_as_list

      def self.for_select
        order('position asc')
      end

      def insert_after=(value)
        if value == "0"
          self.position = 1
        else
          prior = self.class.find value
          if prior.present?
            self.position = prior.position
          end
        end

      end
    end
  end
  
end