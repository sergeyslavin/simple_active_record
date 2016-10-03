require "minitest/autorun"
require_relative '../parser/json_parser'

class TestJsonParser < Minitest::Test
  def setup
    @parser_result = Parser::JSONParser.new
  end

  def test_loading_error
    assert_nil @parser_result.parse_from_file(File.join(File.dirname(__FILE__), "user.json"))
  end

  def test_loaded_structure
    #[{"name": "User1", "age":23}, {"name": "User2", "age":25}]
    assert_equal @parser_result.parse_from_file(File.join(File.dirname(__FILE__), "users.json")),
                [{"name"=>"User1", "age"=>23}, {"name"=>"User2", "age"=>25}]
  end
end
