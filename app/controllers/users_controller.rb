class UsersController < ApplicationController

  before_action :signed_in_user, only: [:index, :edit, :update, :destroy] #Листинг 9.12. Добавление предфильтра
                                                        #  signed_in_user
  before_action :correct_user,   only: [:edit, :update] # Листинг 9.14. Предфильтр 
                                                        #correct_user для защиты edit/update 
  before_action :admin_user,     only: :destroy  
                                                     
  
  # Листинг 9.22. Действие index контроллера Users.
  def index
    #@users = User.all
  @users = User.paginate(page: params[:page]) #Листинг 9.34. Пагинация пользователей в index действии
  end

  def show
    @user = User.find(params[:id])   # або  @user = User.find(1)
  end 

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user # Листинг 8.27. Вход пользователя сразу после регистрации
      flash[:success] = "Welcome to the Sample App!" # Добавление флеш сообщения
                                                    # к успешной регистрации пользователя. 
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # Before filters

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
