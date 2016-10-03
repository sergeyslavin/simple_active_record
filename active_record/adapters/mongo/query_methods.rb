require_relative '../../abstract_query_methods'

module ActiveRecord
  module Adapters
    module Mongo
      module QueryMethods
        include AbstractQueryInstanceMethods
        def self.included(base)
          base.extend ClassMethods
        end

        def save
          DatabaseConnection.connection.collection(self.table_name).insert_one(properties)
        end

        module ClassMethods
          include AbstractQueryClassMethods
          # Method find, receive id like find("1") or find(condition: "id=?, name=?", ["13123", "sergey"])
          # and Return array or models
          def find(condition_string = nil, *props)
            props ||= []
            if condition_string.nil?
              raise "You should provide 'id' or 'condition at first1'"
            end
            condition = {}
            if !BSON::ObjectId.legal?(condition_string)
              if condition_string.count("?") == props.size
                condition_list = Helper.generate_condition_list(condition_string, props)
                if condition_list.count == 1
                  condition = condition_list.first
                else
                  condition = condition_list
                end
              else
                raise "Condition: #{condition_string} has error.You should pass: #{condition_string.count("?")} number of params. Please, check it!"
              end
            else
              condition[:_id] = BSON::ObjectId(condition_string)
            end

            if condition.is_a? Array
              condition = { "$or":  condition }
            end

            items_for_return = []
            DatabaseConnection.connection.collection(self.table_name).find(condition).to_a.each do |item|
              items_for_return << self.new(item)
            end
            items_for_return
          end

          def helper
            Helper
          end

          class Helper
            class << self
              def get_spacial_sign(element)
                match_result = /(\>\=|\>|\<\=|\<|\=)/.match(element)
                match_result.to_a[0]
              end

              def generate_condition_list(condition_string, props)
                condition_list = condition_string.split(",").inject([]) { |list, element|
                  special_sign = get_spacial_sign(element)
                  element_without_white_space = element.gsub(/\s+/, '')
                  argument_item = element_without_white_space.split(special_sign).last
                  argument_value = argument_item == "?" ? props.shift : argument_item
                  condition_value = generate_condition_item(element.strip, argument_value)
                  list << condition_value
                  list
                }
                condition_list
              end

              def generate_condition_item(element, actual_value)
                special_sign = get_spacial_sign(element)
                condition = {}
                key, _ = element.split(special_sign).map!(&:strip)
                case special_sign
                when ">="
                  condition[key] = { "$gte" => actual_value }
                when ">"
                  condition[key] = { "$gt" => actual_value }
                when "<"
                  condition[key] = { "$lt" => actual_value }
                when "=<"
                  condition[key] = { "$lte" => actual_value }
                when "="
                  condition = { key => actual_value }
                else
                end
                condition
              end
            end
          end
        end
      end
    end
  end
end
