module Resourceful
  
  module SortableList
    extend ActiveSupport::Concern
    included do

      acts_as_list
      before_update :move_to_position

      def self.for_select
        order('position asc')
      end

      def insert_after=(value)
        if value == "0"
          @move_to_position = 1
        else
          prior = self.class.find value
          if prior.present?
            @move_to_position = prior.position
          end
        end

      end

      protected

      def move_to_position
        insert_at(@move_to_position) if @move_to_position.present?
      end

      def insert_at_position(position)
        remove_from_list
        increment_positions_on_lower_items(position)
        self.position = position
      end  
    end
  end
  
end