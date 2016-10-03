require "minitest/autorun"
require_relative '../user'

class TestModel < Minitest::Test
  def setup
    @user = User.new
    @user.age = 10
  end

  def test_model_get_value
    assert_equal(@user.age, 10)
  end

  def test_model_change_value
    @user.age = 20
    assert_equal(@user.age, 20)
  end

  def test_non_valid_value_assign_array
    assert_raises NoMethodError do
      @user.value = [1,2,3,4]
    end
  end

  def test_non_valid_value_assign_hash
    assert_raises NoMethodError do
      @user.value = {}
    end
  end

  def test_non_valid_value_assign_any_object
    assert_raises NoMethodError do
      @user.value = @user
    end
  end

  def test_model_init
    object_fixture = { age: 23, name: "User1" }
    user_model = User.new(object_fixture)
    assert_respond_to(user_model, :age)
  end

  def test_model_naming_default_pluralize
    User.table_name = User.to_s #default table name assign
    assert_equal(User.table_name, "users")
  end

  def test_model_naming_assign_snake_case
    User.table_name = "TableName"
    assert_equal(User.table_name, "table_names")
  end
end
