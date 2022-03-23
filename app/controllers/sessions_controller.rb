class SessionsController < ApplicationController
  def new
  end
  def create
    friend = Friend.find_by(id: params[:id].downcase)
    if friend && friend.password_digest == params[:password].crypt('secure_key')
      log_in friend
      redirect_to root_path
    else
      render 'new'
    end
  end
  def destroy
    log_out if logged_in?
    redirect_to login_path
  end
end
