require "minitest/autorun"
require_relative '../parser/ini_parser'

class TestIniParser < Minitest::Test
  def setup
    @parser_result = Parser::IniParser.new
  end

  def test_loading_error
    assert_nil @parser_result.parse_from_file(File.join(File.dirname(__FILE__), "post.ini"))
  end

  def test_loaded_structure
    # [0][title] = "Title1"
    # [1][title] = "Title2"
    assert_equal @parser_result.parse_from_file(File.join(File.dirname(__FILE__), "posts.ini")),
                [{"title"=>"Title1"}, {"title"=>"Title2"}]
  end
end
