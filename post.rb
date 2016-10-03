require_relative 'active_record/active_record_base'

class Post < ActiveRecord::Base
  self.table_name = "user_posts"
end
