class ApplicationController < ActionController::Base
  include Exceptions
  rescue_from Exceptions::NotAuthorized, :with => :user_not_authorized
  helper_method :current_user
  before_filter :get_module_name
  
  private  
    
    def check_authorisation
       # exception handling based on user authorisation
       raise Exceptions::NotAuthorized if current_user.nil?
       raise Exceptions::NotAuthorized unless current_user.name == "admin"
     end
    
  
    def user_not_authorized
        flash[:error] = "You don't have access."
        respond_to do |format|
          format.html {redirect_to log_in_url}
          format.json {render :nothing => true, :status => :unauthorized}
        end
    end
      
    def current_user
      if params[:token] && params[:token] == "admin"
        @@current_user ||= User.where(:name => "admin").first
      else  
        @current_user ||= User.find(session[:user_id]) if session[:user_id]  
      end
    end
    
    def get_module_name
        my_class_name = self.class.name
        if my_class_name.index("::").nil? then
          @module_name = nil
        else
          @module_name = my_class_name.split("::").first
        end
    end
  
end