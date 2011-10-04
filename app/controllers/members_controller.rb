class MembersController < ApplicationController
  respond_to :html, :json
  
  def show
    @member = Member.find(params[:id])
    respond_with do |format|
       format.html # show.html.erb
       format.json { render json: @member }
     end  
  end

end