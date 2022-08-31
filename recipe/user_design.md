# User - Model and Repository Classes Design Recipe

## 1. Design and create the Table
```sql
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name text,
  username text,
  email text,
  password text
);
```
## 2. Create Test SQL seeds



## 3. Define the class names
```ruby
# Table name: users

# Model class
class User
end

# Repository class
class UserRepository
end
```

## 4. Implement the Model class

```ruby
# Model class
class User
  attr_accessor :id, :name, :username, :email, :password
end
```

## 5. Define the Repository Class interface

```ruby
# Repository class
class UserRepository

  # Selecting all records
  def all
    # SELECT id, name, username, email FROM users;
  end

  # Gets a single record by its ID
  def find(id)
    # SELECT id, name, username, email FROM users WHERE id = $1;
  end

  # Adds new record to the 'users' table
  def create(new_user)
    # INSERT INTO users (name, username, email) VALUES ($1, $2, $3);
  end

  # Updates the 'users' table
  def update(id, col, val)
    # UPDATE users SET username = $3 WHERE id = $1;
  end

  # Removes a record from the 'users' table
  def delete(username)
    # DELETE FROM users WHERE username = $1;
  end
end
```

## 6. Write Test Examples

```ruby
# 1. Get all users
repo = UserRepository.new

users = repo.all

users.length # =>  3

users[0].id # =>  1
users[0].name # =>  'Moe'
users[0].username # =>  'moeee'
users[0].email # =>  'moeee@gmail.com'

users[1].id # =>  2
users[1].name # =>  'Row'
users[1].username # =>  'toeeez'
users[1].email # =>  'toeeez@email.com'

users[2].id # =>  3
users[2].name # =>  'Cow'
users[2].username # =>  'coweez'
users[2].email # =>  'coweez@email.com'

# 2. Get a single user by id
repo = UserRepository.new

user = repo.find(1)

user.id # =>  1
user.name # =>  'Moe'
user.username # =>  'moeee'
user.email # =>  'moeee@gmail.com'

# 3. Adds new record to the 'users' table
repo = UserRepository.new

new_user = User.new
new_user.name = 'Marie'
new_user.username = 'ma_rie'
new_user.email = 'test4@email.com'
repo.create(new_user)

users = repo.all

users.length # =>  4
users.last.username # =>  'ma_rie'
users.last.email # =>  'test4@email.com'


# 4. Get a single user by username
repo = UserRepository.new

user = repo.find_by_username('username_2')

users[1].id # =>  2
users[1].name # =>  'Row'
users[1].username # =>  'username_2'
users[1].email # =>  'test2@email.com'

# 5. updates a username
repo = UserRepository.new
repo.update(2, 'username', 'del_m')

users = repo.all
users[1].id # =>  '2'
users[1].name # =>  'name3'
users[1].username # =>  'del_m'
users[1].email # =>  'test3@email.com'

# 6. deletes a user
repo = UserRepository.new

repo.delete(1)
users = repo.all

users.length # =>  2
users.first.id # =>  2

```
## 7. Reload the SQL seeds before each test run
```ruby
# EXAMPLE
def reset_users_table
  seed_sql = File.read('spec/seeds_chitter.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'chitter_testing' })
  connection.exec(seed_sql)
end

describe UserRepository do
  before(:each) do 
    reset_users_table
  end
end
```

## 7. Test-drive and implement the Repository class behaviour
```
Follow the test-driving process of red, green, refactor to implement the behaviour.

```