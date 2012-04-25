module Resourceful
  
  module FormApiMethods

    def input(name, opts={})
      _resourceful_process_item(:inputs, name, opts)
    end
    
    def exclude_input(name)
      _resourceful_exclude_item :inputs, name
    end

    def legend(title)
      _resourceful_process_item :inputs, nil, {:as => :legend, :label => title}
    end
    
    def fieldset(side, &block)
      _resourceful_process_item :inputs, nil, {:as => :fieldset, :fieldset => Fieldset.new(side, &block)}
    end
  end
  
  module FormApi

    extend ActiveSupport::Concern

    included do
      
      decorate_class_with FormApiMethods

      class_attribute :inputs, instance_reader: true
      self.inputs = []
      
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