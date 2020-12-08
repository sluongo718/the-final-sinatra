class UsersController < ApplicationController

    get "/signup" do 
        erb :"users/signup"
    end

    post "/signup" do 
        user = User.new(params[:user])
        if user.save
            session[:user_id] = user.id
            redirect to "/users/#{user.id}"
        else 
            @errors = user.errors.full_messages
            erb :'users/signup'
        end 
    end

    get "/signin" do 

        erb :"users/signin"

    end

    post "/signin" do 
        user = User.find_by_username(params[:user][:username])
            if user && user.authenticate(params[:user][:password])
                session[:user_id] = user.id

                redirect to "/users/#{user.id}"
            
            else
                flash[:message] = "sorry seems like your username and/or password is incorrect please try again"
                redirect to "/signin"
            end
        
    end



    get "/users/:id" do 
            @user = User.find_by_id(params[:id])
            erb :"users/show"
    end

    get "/logout" do 
        session.clear
        redirect to "/signin"

    end

end
