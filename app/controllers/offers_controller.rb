class OffersController < ApplicationController
  
  respond_to :html, :json
  before_filter :check_registered
  
  # GET /members/1/offers
  # Provides a list of the Member's Current Offers
  def index
    #@member = Member.find(params[:member_id])
    @products = @member.products
  end
  
  def show
    @product = Product.find(params[:id])
    Log.make(session[:user_id], {:member_id => params[:member_id], :product => @product.id, :action => :click, :type => :offer})
    respond_with do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end
  
  # Used for a dummy adding an offer to the member's "card"
  # PUT /members/1/offer
  def update
    #logs should really be filters
    Log.make(session[:user_id], {:member_id => params[:member_id], :product => params[:id], :action => :load, :type => :offer})
    redirect_to member_offer_path(params[:member_id], params[:id])
  end
  
  private
  
  def check_registered
    @member = Member.first( conditions: { id: params[:member_id]} )
    if  @member.nil?
      render :text => "Not Found", :status => 404
    elsif !@member.registered
      flash[:error] = "You haven't registered yet."
      respond_to do |format|
        format.html {redirect_to member_path(@member)}
      end
    end
  end
  
  
end
