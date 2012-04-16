module Resourceful
  
  module MemberPageMethods

    def show(name, opts={})
      if name.is_a? Hash
        opts = name 
      else
        opts[:name] = name
      end
      opts.symbolize_keys!
      
      if opts[:tab]
        opts[:as] = :tab
      end
      
      @attributes_to_show ||= []
      @attributes_to_show << opts
    end

    def heading(title)
      @attributes_to_show ||= []
      @attributes_to_show << {:as => :heading, :label => title}
    end
    
    def panel(side, &block)
      @attributes_to_show ||= []
      @attributes_to_show << {:as => :panel, :panel => Panel.new(side, &block)}
    end
    
  end
  
  module MemberPageApi
    
    extend ActiveSupport::Concern
    
    included do
      
      self.extend MemberPageMethods
      
      def attributes_to_show;         self.class.attributes_to_show || []; end
      
      protected 
      
      def self.attributes_to_show;    @attributes_to_show; end

      @attributes_to_show = []
      
    end
    
  end
  
  class Panel
    include MemberPageMethods
    attr_reader :attributes_to_show, :side

    def initialize(side, &block)
      @side = side
      instance_eval(&block) if block_given?
    end

  end
  
  class Tab
    attr_reader :tab, :title
    def initialize(opts)
      @tab, @title = opts[:tab], opts[:title] || opts[:tab].to_s.humanize.titleize
    end
  end
  
end