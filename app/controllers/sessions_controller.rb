class SessionsController < ApplicationController
  def new
  end
  def create  
      user = User.authenticate(params[:name], params[:password])  
      if user
        reset_session
        session[:user_id] = user.id.to_s
        redirect_to admin_members_path, :notice => "Logged in!"  
      else  
        flash.now.alert = "Invalid email or password"  
        render "new"  
      end  
  end
  
  def destroy  
    session[:user_id] = nil  
    redirect_to root_url, :notice => "Logged out!"  
  end
  
end
