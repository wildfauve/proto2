class Admin::LogsController < ApplicationController
  
  before_filter :check_authorisation
  respond_to :html, :json
  
  def index
    @logs = Log.all
  end
  
end
