# Post - Model and Repository Classes Design Recipe

## 1. Design and create the Table
```sql
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  message text,
  timestamp timestamp,
  user_id int,
  constraint fk_user foreign key(user_id) references users(id)
);
```
## 2. Create Test SQL seeds
```ruby
# Table name: posts

# Model class
class Post
end

# Repository class
class PostRepository
end
```

## 3. Implement the Model class
```ruby
# Model class
class Post
  attr_accessor :id, :message, :timestamp, :user_id
end
```

## 4. Define the Repository Class interface
```ruby
# Repository class
class PostRepository
  # Selecting all records
  def all
    # SELECT id, message, timestamp, user_id FROM posts;
  end

  # Gets a single record by its ID
  def find(id)
    # SELECT id, message, timestamp, user_id FROM posts WHERE id = $1;
  end

  # Gets a single record by its postname
  def find_by_user_id(user_id)
    # SELECT id, message, timestamp, user_id FROM posts WHERE user_id = $1;
  end

  # Adds new record to the 'posts' table
  def create(new_post)
    # INSERT INTO posts (message, timestamp, user_id) VALUES ($1, $2, $3);
  end

  # Updates the 'posts' table
  def update(id, col, val)
    # UPDATE posts SET message = $2 WHERE id = $1;
  end

  # Removes a record from the 'posts' table
  def delete(id)
    # DELETE FROM posts WHERE id = $1;
  end
end
```

## 5. Write Test Examples

```ruby
# EXAMPLES

# 1. Get all posts
repo = PostRepository.new

posts = repo.all

posts.length # =>  4

posts[0].id # =>  1
posts[0].message # =>  'First'
posts[0].timestamp # => '2022-07-15 10:23:54'
posts[0].user_id # =>  1

posts[1].id # =>  2
posts[1].message # =>  'Second'
posts[1].timestamp # => '2022-07-15 10:24:54'
posts[1].user_id # =>  2

posts[2].id # =>  3
posts[2].message # =>  'Third'
posts[2].timestamp # => '2022-07-16 10:25:54'
posts[2].user_id # =>  3

# 2. Get a single post by id
repo = PostRepository.new

post = repo.find(1)

post.id # =>  1
post.message # =>  'First'
post.timestamp # => '2022-07-15 10:23:54'
post.user_id # =>  1

# 3. Adds new record to the 'posts' table
repo = PostRepository.new

new_post = Post.new
new_post.message # = 'rain'
new_post.timestamp# = '2022-07-17 10:26:54'
new_post.user_id #= 3
repo.create(new_post)

posts = repo.all

posts.length # =>  5
posts.last.message # =>  'rain'
posts.last.user_id # =>  3

# 4. updates a message
repo = PostRepository.new
repo.update(2, 'message', 'cloud')

posts = repo.all
posts[1].id # =>  2
posts[1].message # =>  'cloud'
posts[1].timestamp # =>  '2022-07-15 10:24:54'
posts[1].user_id # =>  2


# 5. 'deletes a post' do
repo = PostRepository.new

repo.delete(1)
posts = repo.all

posts.length # =>  3
posts.first.id # =>  2

```
## 6. Reload the SQL seeds before each test run

```ruby
# EXAMPLE

def reset_posts_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'chitter_testing' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do 
    reset_posts_table
  end
end
```

## 7. Test-drive and implement the Repository class behaviour
```
Follow the test-driving process of red, green, refactor to implement the behaviour.

```