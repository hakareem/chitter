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

end


