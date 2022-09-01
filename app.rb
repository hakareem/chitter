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

  get '/login' do
    return erb :login
  end

end


