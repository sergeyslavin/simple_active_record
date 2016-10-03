require_relative 'config'
require_relative 'database_connection'
require_relative 'active_record_helper'
require_relative 'active_record_access'
require_relative 'props_generator'

module ActiveRecord
  class Base
    include PropsGenerator
    include Access
    include Config.QueryMethods

    def initialize(properties = {})
      if properties.is_a? Hash
        @@properties = properties
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      all_property_keys = @@properties.keys.map(&:to_s)
      all_property_keys.include? method_name.to_s || super
    end

    def method_missing(name, *args, &block)
      handle_props(name, *args) { super }
    end
  end
end
