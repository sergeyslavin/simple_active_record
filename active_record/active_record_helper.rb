module ActiveRecord
  module Helper
    module StringHelper
      refine String do
        def snake_case
          self.gsub(/::/, '/').
          gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
          gsub(/([a-z\d])([A-Z])/,'\1_\2').
          tr("-", "_").
          downcase
        end

        def pluralize
          if last_char = self.split("").last and last_char == "s"
            return self
          else
            return self + "s"
          end
        end
      end
    end
  end
end
