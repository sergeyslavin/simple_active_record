require_relative 'adapters/mongo/boot'

module ActiveRecord
  class Config
    def self.Adapter
      Adapters::Mongo
    end
    
    def self.QueryMethods
      self.Adapter::QueryMethods
    end
  end
end
