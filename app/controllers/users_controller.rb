class UsersController < ApplicationController
  before_action :set_profile, only: %i[profile edit update ]
  before_action :authenticate_user!

  def index
    @users = User.all
  end


  def profile
    @user = current_user
    @books = Book.all
  end

  
  def edit  
  end


  def show
    @user = User.find(params[:id])
  end
    

  def update
    if @user.update(profile_params)
      flash[:success] = "Profile updated."
      redirect_to user_profile_path
    else
      render "edit"
    end 
  end

  
  private

    def set_profile
      @user = current_user
    end

    def profile_params
      params.require(:user).permit(:profile_picture, :first_name, :last_name, :username, :bio)
    end
end
