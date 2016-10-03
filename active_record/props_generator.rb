module ActiveRecord
  module PropsGenerator
    @@properties ||= {}
    def properties
      @@properties
    end

    def handle_props(name, *args, &block)
      if !should_handle?(name, *args)
        if block_given?
          block::()
        end
      end
      if name =~ /\=/
        name_for_set = name.to_s.chop
        @@properties[name_for_set] = args[0]
      else
        return @@properties.fetch(name.to_s, nil)
      end
    end

    private
    def should_handle?(name, *args)
      if args.count > 1
        return false
      end

      if !args[0].nil?
        if !args[0].is_a? String and !args[0].is_a? Numeric
          return false
        end
      end

      if name !~ /\=/ && @@properties && @@properties[name.to_s].nil?
        return false
      end
      return true
    end
  end
end
