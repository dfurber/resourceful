module Resourceful
  module ListBuilder
    def _resourceful_process_item(type, name, opts={})
      opts.symbolize_keys!
      opts[:name] = name
      if opts.key?(:prepend)
        send(type).unshift opts
      elsif opts.key?(:before) or opts.key?(:after)
        key = _get_index_for type, (opts[:before] || opts[:after])
        if key
          send(type).insert (opts.key?(:before) ? key : key+1), opts
          return
        end
      end
      send(type) << opts
    end

    def _resourceful_exclude_item(type, name)
      send "#{type}=", send(type).map {|value| value[:name] == name ? nil : value }.compact

    end

    def _get_index_for(type, name)
      needle = nil
      self.send(type).each_with_index {|item, i| needle = i if item[:name] == name }
      needle
    end
  end
end