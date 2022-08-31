require_relative 'post.rb'

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