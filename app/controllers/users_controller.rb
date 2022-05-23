class UsersController < ApplicationController
  def new; end

  def show
    @user = User.find(params[:id])
  end

  def create
    user = User.create(user_params)
    if user.save
      redirect_to "/users/#{user.id}"
    else
      flash.now[:alert] = user.errors.full_messages.to_sentence.to_s
      render 'new'
    end
  end

  def login_form; end

  def login_user
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome #{user.name}"
      redirect_to "/users/#{user.id}"
    else
      flash[:error] = 'Invalid email/password'
      render :login_form
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
