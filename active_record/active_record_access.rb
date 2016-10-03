module ActiveRecord
  module Access
    using Helper::StringHelper
    def self.included(base)
      base.class_eval do
        include ObjectMethods
      end
      base.extend ClassMethods
    end

    module ObjectMethods
      def table_name
        self.class.table_name
      end
    end

    module ClassMethods
      def table_name=(table_name)
        @table_name = table_name.pluralize.snake_case
      end
      def table_name
        @table_name || self.to_s.pluralize.snake_case
      end
    end
  end
end
