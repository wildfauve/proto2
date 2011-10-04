class RegistersController < ApplicationController
  
  respond_to :html, :json
  
  # GET /members/1/registers
  def index
    Rails.logger.info(">>>Register Controller>>Index: #{params.inspect}")
    @member = Member.find(params[:member_id])
    respond_with do |format|
      format.html # index.html.erb
      format.json { render json: @members }
    end
  end

  # POST /members/1/registers
  # Called when member registers
  def create
    @member = Member.find(params[:member_id])
    respond_with do |format|
      if @member.update_attributes(:registered => true)
        Log.make(session[:mem_id], {:member => @member.id, :action => :register})
        format.html { redirect_to member_register_path(@member.id, 1) }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def show
    @member = Member.find(params[:member_id])
  end
  
  def new
  end
  
  # DELETE /members/1/registers
  # Called when member registers
  def destroy
    @member = Member.find(params[:member_id])
    respond_with do |format|
      if @member.update_attributes(:registered => false, :reg_date => nil)
        Log.make(session[:mem_id], {:member => @member.id, :action => :deregister})
        format.html { redirect_to member_register_path(@member.id, 1) }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end
end
