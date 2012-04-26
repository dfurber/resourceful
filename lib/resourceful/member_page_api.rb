module Resourceful
  
  module MemberPageMethods

    def show(name, opts={})
      opts.symbolize_keys!
      if name.is_a? Hash
        opts = name 
      else
        opts[:name] = name
      end      
      if opts[:tab]
        opts[:as] = :tab
        opts[:name] = opts[:tab]
      end

      @attributes_to_show = _resourceful_process_item(@attributes_to_show, name, opts)
    end
    
    def hide(name)
      @attributes_to_show = _resourceful_exclude_item @attributes_to_show, name
    end

    def heading(title)
      opts = {:as => :heading, :label => title}
      @attributes_to_show = _resourceful_process_item(@attributes_to_show, title, opts)
    end
    
    def panel(side, &block)
      opts = {:as => :panel, :panel => Panel.new(side, &block)}
      @attributes_to_show = _resourceful_process_item(@attributes_to_show, nil, opts)
    end
    
  end
  
  module MemberPageApi
    
    extend ActiveSupport::Concern
    
    included do
      
      decorate_class_with MemberPageMethods
      
      @attributes_to_show = []
      def self.attributes_to_show
        @attributes_to_show
      end
      def attributes_to_show
        self.class.attributes_to_show || []
      end
      
    end
    
  end
  
  class Panel
    include MemberPageMethods
    include ListBuilder
    attr_reader :attributes_to_show, :side

    def initialize(side, &block)
      @side = side
      @attributes_to_show = []
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