require_relative '../../abstract_connection'
require 'yaml'
require 'mongo'

module ActiveRecord
  module Adapters
    module Mongo
      class DatabaseConnection < AbstractConnection
        attr_reader :db

        def self.connection
          @__instance ||= new
        end

        def config_path
          super
        end

        def collection(collection_name)
          @db.database[collection_name]
        end

        def initialize
          config = YAML.load_file(config_path())["default"]
          @db = ::Mongo::Client.new([config["host"]], :database => config["database"])
        end
      end
    end
  end
end
