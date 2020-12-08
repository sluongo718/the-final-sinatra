require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
    register Sinatra::Flash
  end

  # get "/" do
  #   erb :welcome
  # end

  get "/" do 
      erb :home
  end

  helpers do 
      def logged_in?
          !!session[:user_id]
      end

      def current_user
        @current_user ||= User.find_by_id(session[:user_id])
    end 

    def redirect_if_not_logged_in
      if !logged_in?
        flash[:message] = "Please log in before continuing!"
      
        redirect to '/signin'
      end 
    end

    def sry_not_your_pokemon 
      flash[:message] = "sorry seems thats not your pokemon"
    end
  end

end
