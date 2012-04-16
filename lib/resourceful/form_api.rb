module Resourceful
  
  module FormApiMethods
    def input(name, opts={})
      opts.symbolize_keys!
      opts[:name] = name
      @inputs ||= []
      @inputs << opts
    end
    
    def legend(title)
      @inputs ||= []
      @inputs << {:as => :legend, :label => title}
    end
    
    def fieldset(side, &block)
      @inputs ||= []
      @inputs << {:as => :fieldset, :fieldset => Fieldset.new(side, &block)}
    end
  end
  
  module FormApi

    extend ActiveSupport::Concern

    included do

      self.extend FormApiMethods

      def inputs;                     self.class.inputs || []; end

      protected
      
      def self.inputs;                @inputs; end

      @inputs = []
            
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