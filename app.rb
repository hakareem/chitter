require_relative './lib/database_connection'
require 'sinatra/base'
require 'sinatra/reloader'
require_relative './lib/user_repository'
require_relative './lib/post_repository'

DatabaseConnection.connect('chitter_testing')

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb :home
  end

  get '/tweets' do
    @users_repo = UserRepository.new
    @posts_repo = PostRepository.new

    return erb :tweets
  end

  get '/signup' do
    return erb :signup
  end

  post '/signup' do
    @users_repo = UserRepository.new
    email = params[:email]
    username = params[:username]

    # checking if username OR email exists in db 
    if @users_repo.find_username(username) == nil && @users_repo.find_email(email) == nil 
      @user = User.new
      @user.email = params[:email]
      @user.username = params[:username]
      @user.name = params[:name]
      @user.password = params[:password]

      # only create a user when signup conditions are met
      if signup_valid?
        @users_repo.create(@user)
        # binding.irb
        return erb :signup_successful
      end

    # checking if usernames exists in the database
    elsif @users_repo.find_username(username) != nil 
      erb :username_exists
    else 
      erb :email_exists
    end
  end

  # conditions for signup form
  def signup_valid?
  return (params[:name].length > 3 && params[:password].length > 6 && params[:username].length > 3 && params[:email].length > 6 && params[:email].include?("@"))
  end

  get '/login' do
    return erb :login
  end

  post '/login' do
    @users_repo = UserRepository.new
    @posts_repo = PostRepository.new
    username = params[:username]
    password = params[:password]

    # if username doesn't exist in db then you can't login
    @user = @users_repo.find_username(username) 
    if @user == nil 
      return erb :login_failed
    end

    # if the password for that user doesn't match then you can't login
    if @user.password != params[:password] 
      return erb :login_failed
    end

    return erb :user
  end

  post '/tweet' do
    @users_repo = UserRepository.new
    @posts_repo = PostRepository.new

    # find the user trying to make the post through id
    user_id = params[:user_id].to_i
    @user = @users_repo.find(user_id)

    # creating a new post record
    post = Post.new
    post.message = params[:message]
    post.timestamp = params[:timestamp]
    post.user_id = params[:user_id].to_i
    @posts_repo.create(post)

    return erb :user
  end
end


