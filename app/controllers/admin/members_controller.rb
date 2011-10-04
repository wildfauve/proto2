class Admin::MembersController < ApplicationController
  
  before_filter :check_authorisation
  respond_to :html, :json
  
  # GET /members
  # GET /members.json
  def index
    @members = Member.all

    respond_with do |format|
      format.html # index.html.erb
      format.json { render json: @members }
    end
  end

  # GET /members/1
  # GET /members/1.json
  def show
    @member = Member.find(params[:id])

    respond_with do |format|
      format.html # show.html.erb
      format.json { render json: @member }
    end
  end

  # GET /members/new
  # GET /members/new.json
  def new
    @member = Member.new

    respond_with do |format|
      format.html # new.html.erb
      format.json { render json: @member }
    end
  end

  # GET /members/1/edit
  def edit
    @member = Member.find(params[:id])
  end

  # POST /members
  # POST /members.json
  def create
    Rails.logger.info(">>>Member Controller>>CREATE: #{params.inspect}, #{request.format}")
    if request.format == :json
      @member = Member.new(params[:member])
    else
      @member = Member.new(params[:memberandprod][:member])
    end

    respond_with do |format|
      if @member.save
        #UserMailer.welcome_email(@member).deliver
        reg_id = url_for member_registers_path(@member)
        #Rails.logger.info(">>>Member Controller>>CREATE: #{@member.inspect}")
        
        @member.modify_products(params[:memberandprod][:products]) if params[:memberandprod]
                
        format.html { redirect_to admin_member_path(@member), notice: "For Registration use: #{reg_id}." }
        format.json { render :jsonify => @member, :status => :created, :location => member_path(@member) }
      else
        format.html { render action: "new" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /members/1
  # PUT /members/1.json
  def update
    @member = Member.find(params[:id])
    Rails.logger.info(">>>Member Controller>>UPDATE: #{params.inspect}")

    respond_with do |format|
      if @member.update_attributes(params[:memberandprod][:member])
        
        @member.modify_products(params[:memberandprod][:products]) if params[:memberandprod][:products]
        
        format.html { redirect_to admin_member_path(@member), notice: 'Member was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member = Member.find(params[:id])
    @member.destroy

    respond_with do |format|
      format.html { redirect_to admin_members_url }
      format.json { head :ok }
    end
  end
  
end
