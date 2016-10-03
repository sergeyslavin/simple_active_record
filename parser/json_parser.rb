require_relative 'abstract_parser'
require 'json'

module Parser
  class JSONParser < AbstractParser
    def parse_from_file(file_path)
      file_data = nil
      begin
        file_data = File.read(file_path)
        parse(file_data)
      rescue Exception => exp
        puts exp.message
      ensure
        file_data
      end
    end

    private
    def parse(data)
      JSON.parse(data)
    end
  end
end
