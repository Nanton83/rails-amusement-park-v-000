class UsersController < ApplicationController
    before_action :authenticate_user, only: [:show]
  
    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        render 'new'
      end
    end
    
    def show
      @user = User.find_by(id: params[:id])
      if !current_user.admin
        if current_user != @user
          redirect_to root_path
        end
      end
    end 
  
    def edit
    end
  
    def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end
  
  
      def user_params
        params.require(:user).permit(:name, :password, :height, :tickets, :happiness, :nausea, :admin)
      end
  end
