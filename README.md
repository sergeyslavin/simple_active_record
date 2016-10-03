# Simple Active Record
## Using
```ruby
#include base active record file
require_relative 'active_record/active_record_base'

#inherit ActiveRecord::Base to access functional
class Post < ActiveRecord::Base
  self.table_name = "PostModel"
end

```

 ```self.table_name``` - optional property. By Default it uses model class name and tranform to snake case and make pluralize. Example: ```self.table_name = "PostModel"``` - will create "post_models" table name. In case with mongo, this property uses for creating collecion.
 
 ## Access
Model creates access for property automatically. You can assign only String or Numeric types. In other case will be exception.

 ```ruby
 
 post = Post.new
 post.title = "Title"
 puts post.title #Title
 
 ```
 
 Also you can pass hash in model constructor.
  ```ruby
  post = Post.new({ title: "Title", content: "Content" })
  pust post.title #Title
  ```
  
  ## Commit
  To save changes you need to call ```Model#save``` method and it will create new record in database.
  ```ruby
  post = Post.new({ title: "Title", content: "Content" })
  post.save
  ```
  
  ## Find
  To find element in database you need to use ```Model#find```. This method takes one required parameter and another optional.
  To Find element by ```id``` you just need to pass it like argument.
  ```ruby
  Post.find("post_id")
  ```
  Method ```find``` should return list of models with fetched parameters from database. If method didn't find any data  it should return empty array.
 Also you can create conditions for ```find```. Example:
 ```ruby
 Post.find("name = ?", "User") #support conditions: <=, >=, <,>,=
 ```
 As well you can provide parameter in first argument.
  ```ruby
  Post.find("name = User")
  ```
  
  The difference betweeen ```Post.find("name = User") ``` and ```Post.find("name = ?", "User")``` is only one: this case can save types ```Post.find("name = ?", "User")```. It helpful for search by numeric parameters. Example:
  ```ruby
  Post.find("age >= ?", 20)
  ```
  
  You can mix parameters in search. This conditions will use like `or`. Example:
  ```ruby
  Post.find("name = User, age > ?", 20)
  Post.find("name = User, last_name = Been")
  ```
  
  **That's all.**
  ##### To run task to build fixtures you need to exec 
  ```rake file=user.json``` or ```rake parse_file file=user.json``` 

- user.json - it's name of file with fixtures. File name should be equas as model name. **It's important.**

To run tests you need to exec ```rake test```.
  
