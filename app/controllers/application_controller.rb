require "./config/environment"
require "./app/models/user"
class ApplicationController < Sinatra::Base

  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    erb :index
  end

  get "/signup" do
    erb :signup
  end

  post "/signup" do
    #your code here
     user = User.new(params[:username])

        if user.save
            session[:user_id] = user.id 
            redirect to "/users"
        else
          
            erb :"/users/new"
        end

  end

  get '/account' do
    @user = User.find(session[:user_id])
    erb :account
  end


  get "/login" do
    erb :login
  end

  post "/login" do
    ##your code here
     user = User.find_by(username: params[:user][:username])
        
        if user && user.authenticate(params[:user][:password])
            session[:user_id] = user.id
            redirect to "/users/:id"
        else

            redirect to '/login'
        end
  end

  get "/failure" do
    erb :failure
  end

  get "/logout" do
    session.clear
    redirect "/"
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
