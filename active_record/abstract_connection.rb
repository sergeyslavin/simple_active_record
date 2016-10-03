module ActiveRecord
  class AbstractConnection
    def config_path
      File.join(File.dirname(__FILE__), "config.yml")
    end

    def self.connection
      raise NotImplementedError
    end
  end
end
