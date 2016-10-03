$: << File.dirname(__FILE__)

require 'parser/json_parser'
require 'parser/ini_parser'
require 'user'
require 'post'

class Task
  def self.validate_file!(file_name)
    file_path = File.join(File.dirname(__FILE__), file_name)
    if !File.exists? file_path
      raise "File not found!"
    end
  end

  def self.init_with_file_name(file_name)
    file_path = File.join(File.dirname(__FILE__), file_name)
    new(file_name)
  end

  def initialize(file_path)
    @file_path = file_path
  end

  def get_parser_by_name(file_path)
    file_extension = File.extname(file_path)
    parser = nil
    case file_extension
    when ".json"
      parser = Parser::JSONParser.new
    when ".ini"
      parser = Parser::IniParser.new
    else
    end
    parser
  end

  def get_model_by_name(file_path)
    model = nil
    if file_path =~ /user/i
      model = User
    elsif file_path =~ /post/i
      model = Post
    end
    model
  end

  def run!
    parser = get_parser_by_name(@file_path)
    if !parser.nil?
      model = get_model_by_name(@file_path)
      if model.nil?
        raise "Model not found!"
      end
      
      data = load_and_parse(@file_path, parser)

      if data.nil?
        raise "Data cannot be parsed!"
      end

      create_model_by_list(model, data)
    else
      raise "Parser not found!"
    end
  end

  def create_model_by_list(model, data)
    thread = []
    mutex = Mutex.new
    data.each do |item|
      thread << Thread.new(item) { |item_for_create|
        mutex.synchronize do
          user = model.new(item_for_create)
          user.save
        end
      }
      sleep 0.3
    end
    thread.each(&:join)
  end

  def load_and_parse(file_path, parser)
    parser.parse_from_file(file_path)
  end
end
