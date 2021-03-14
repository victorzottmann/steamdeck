class UsersController < ApplicationController
  before_action :set_profile, only: %i[profile edit update ]
  before_action :authenticate_user!

  def profile
    @user = current_user
    @books = Book.all
  end

  def update
    if @user.update(profile_params)
      flash[:success] = "Profile updated."
      redirect_to user_profile_path
    else
      render "edit"
    end 
  end

  def edit  
  end

  private

    def set_profile
      @user = current_user
    end

    def profile_params
      params.require(:user).permit(:profile_picture, :bio)
    end
end
