class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])   # або  @user = User.find(1)
  end 

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!" # Добавление флеш сообщения
                                                    # к успешной регистрации пользователя. 
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

end
