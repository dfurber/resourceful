module Resourceful
  module ListBuilder
    def _resourceful_process_item(list, name, opts={})
      list ||= []
      opts.symbolize_keys!
      opts[:name] = name
      if opts.key?(:prepend)
        list.unshift opts
      elsif opts.key?(:before) or opts.key?(:after)
        key = _get_index_for list, (opts[:before] || opts[:after])
        if key
          list.insert (opts.key?(:before) ? key : key+1), opts
          return
        end
      end
      list << opts
    end

    def _resourceful_exclude_item(list, name)
      list.map {|value| value[:name] == name ? nil : value }.compact
    end

    def _get_index_for(list, name)
      needle = nil
      list.each_with_index {|item, i| needle = i if item[:name] == name }
      needle
    end
  end
end