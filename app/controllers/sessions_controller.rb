class SessionsController < ApplicationController

    def sign_in
        @user = User.new
        @users = User.all
    end
    
    def create
        @user = User.find_by(name: params[:user][:name])
        if @user && @user.authenticate(params[:user][:password])
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            render 'sign_in'
        end
    end
    
    def destroy
        session[:user_id] = nil
        redirect_to root_path
    end

end
