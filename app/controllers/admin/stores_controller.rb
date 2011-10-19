class Admin::StoresController < ApplicationController
    
    before_filter :check_authorisation  
    respond_to :html, :json

    # GET /stores
    # GET /stores.json
    def index
      @stores = Store.all

      respond_with do |format|
        format.html # index.html.erb
      end
    end

    # GET /stores/1
    # GET /stores/1.json
    def show
      @store = Store.find(params[:id])

      respond_with do |format|
        format.html # show.html.erb
      end
    end

    # GET /stores/new
    # GET /stores/new.json
    def new
      @store = Store.new

      respond_with do |format|
        format.html # new.html.erb
      end
    end

    # GET /stores/1/edit
    def edit
      @store = Store.find(params[:id])
      #Rails.logger.info(">>>store Controller>>EDIT: #{@store.inspect}")
    end

    # POST /stores
    # POST /stores.json
    def create
      Rails.logger.info(">>>store Controller>>CREATE: #{params.inspect}")
      @store = Store.new(params[:store])

      respond_with do |format|
        if @store.save
          format.html { redirect_to admin_stores_path, notice: "store Created" }
        else
          format.html { render action: "new" }
        end
      end
    end

    # PUT /stores/1
    # PUT /stores/1.json
    def update
      @store = Store.find(params[:id])
      respond_with do |format|
        if @store.update_attributes(params[:store])
          format.html { redirect_to admin_stores_path, notice: 'store was successfully updated.' }
        else
          format.html { render action: "edit" }
        end
      end
    end

    # DELETE /stores/1
    # DELETE /stores/1.json
    def destroy
      @store = Store.find(params[:id])
      @store.destroy

      respond_with do |format|
        format.html { redirect_to admin_stores_path }
      end
    end


end
