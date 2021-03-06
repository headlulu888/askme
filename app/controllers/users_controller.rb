class UsersController < ApplicationController

  before_action :load_user, except: [:index, :create, :new]
  before_action :authorize_user, except: [:index, :create, :new, :show]

  def index
    @users = User.all
  end

  def new
    redirect_to root_url, alert: 'Вы уже залогинились' if current_user.present?
    @user = User.new
  end

  def create
    redirect_to root_url, alert: 'Вы уже залогинились' if current_user.present?
    @user = User.new(user_params)

    # default color
    @user.profile_color = '#057973'

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Пользователь успешно зарегестрирован!"
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "Данные обновленны!"
    else
      render 'edit'
    end
  end

  def edit
  end

  def show
    # формирует поле по чему можно сортировать
    @questions = @user.questions.order(created_at: :desc)
    @new_question = @user.questions.build

    @questions_count = @questions.count
    @answers_count = @questions.where.not(answer: nil).count
    @unanswered_count = @questions_count - @answers_count
  end

  def destroy
    # выход из профиля и удаление юзера
    session[:user_id] = nil
    @user.destroy

    redirect_to root_path, notice: 'Пользователь удален!'
  end

  private

  def authorize_user
    reject_user unless @user == current_user
  end

  def load_user
    @user ||= User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :name, :username, :avatar_url, :profile_color)
  end
end
