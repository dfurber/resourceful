module Resourceful
  
  module FormApiMethods

    def input(name, opts={})
      @inputs = _resourceful_process_item(@inputs, name, opts)
    end
    
    def exclude_input(name)
      @inputs = _resourceful_exclude_item @inputs, name
    end

    def legend(title)
      @inputs = _resourceful_process_item @inputs, nil, {:as => :legend, :label => title}
    end
    
    def fieldset(side, &block)
      @inputs = _resourceful_process_item @inputs, nil, {:as => :fieldset, :fieldset => Fieldset.new(side, &block)}
    end
  end
  
  module FormApi

    extend ActiveSupport::Concern

    included do
      
      @inputs ||= []
      def self.inputs; @inputs; end
      def inputs;      self.class.inputs || []; end

      decorate_class_with FormApiMethods

    end
    
  end

  class Fieldset

    attr_reader :side, :inputs
        
    include ListBuilder
    include FormApiMethods

    def initialize(side, &block)
      @side = side
      @inputs = []
      instance_eval(&block) if block_given?
    end
    
    

  end


end