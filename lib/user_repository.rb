require './user.rb'

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
