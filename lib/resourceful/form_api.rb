module Resourceful
  
  module FormApiMethods

    def self.input(name, opts={})
      _resourceful_process_item(:inputs, name, opts)
    end
    
    def self.exclude_input(name)
      _resourceful_exclude_item :inputs, name
    end

    # def input(name, opts={})
    #   opts.symbolize_keys!
    #   opts[:name] = name
    #   @inputs ||= []
    #   @inputs << opts
    # end
    
    def legend(title)
      _resourceful_process_item :inputs, nil, {:as => :legend, :label => title}
    end
    
    def fieldset(side, &block)
      @inputs ||= []
      _resourceful_process_item :inputs, nil, {:as => :fieldset, :fieldset => Fieldset.new(side, &block)}
    end
  end
  
  module FormApi

    extend ActiveSupport::Concern
    extend FormApiMethods

    included do

      def inputs;                     self.class.inputs; end

      protected
      
      class_attribute :inputs
      self.inputs = []
      
    end

  end

  class Fieldset

    attr_reader :side, :inputs

    include FormApiMethods

    def initialize(side, &block)
      @side = side
      instance_eval(&block) if block_given?
    end
    
    

  end


end