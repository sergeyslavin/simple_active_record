require "minitest/autorun"
require_relative '../user'

class TestMongoAdapter < Minitest::Test
  def test_condition_get_sign_gte
    assert_equal(User.helper.get_spacial_sign("age >= 10"), ">=")
  end

  def test_condition_get_sign_gt
    assert_equal(User.helper.get_spacial_sign("age > 10"), ">")
  end

  def test_condition_get_sign_eq
    assert_equal(User.helper.get_spacial_sign("age = 10"), "=")
  end

  def test_condition_get_sign_lt
    assert_equal(User.helper.get_spacial_sign("age < 10"), "<")
  end

  def test_condition_get_sign_lte
    assert_equal(User.helper.get_spacial_sign("age <= 10"), "<=")
  end

  def test_condition_with_args
    assert_equal User.helper.generate_condition_list("user_name = ?", ["User1"]), [{"user_name"=>"User1"}]
  end

  def test_condition_with_value
    assert_equal User.helper.generate_condition_list("user_name = User", []), [{"user_name"=>"User"}]
  end

  def test_condition_couple_of_arguments
    assert_equal User.helper.generate_condition_list("user_name = User, age >= ?", [20]), [{"user_name"=>"User"}, {"age"=>{"$gte"=>20}}]
  end
end
