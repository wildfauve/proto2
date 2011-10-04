class Admin::ProductsController < ApplicationController
    
    before_filter :check_authorisation  
    respond_to :html, :json

    # GET /products
    # GET /products.json
    def index
      @products = Product.all

      respond_with do |format|
        format.html # index.html.erb
        format.json { render json: @products }
      end
    end

    # GET /products/1
    # GET /products/1.json
    def show
      @product = Product.find(params[:id])

      respond_with do |format|
        format.html # show.html.erb
        format.json { render json: @product }
      end
    end

    # GET /products/new
    # GET /products/new.json
    def new
      @product = Product.new

      respond_with do |format|
        format.html # new.html.erb
        format.json { render json: @product }
      end
    end

    # GET /products/1/edit
    def edit
      @product = Product.find(params[:id])
      Rails.logger.info(">>>product Controller>>EDIT: #{@product.inspect}")
    end

    # POST /products
    # POST /products.json
    def create
      Rails.logger.info(">>>product Controller>>CREATE: #{params.inspect}")
      @product = Product.new(params[:product])

      respond_with do |format|
        if @product.save
          Rails.logger.info(">>>product Controller>>CREATE: #{@product.inspect}")
          format.html { redirect_to admin_product_path(@product), notice: "Product Created" }
          #format.json { render :jsonify => @product, :status => :created, :location => product_path(@product) }
        else
          format.html { render action: "new" }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    end

    # PUT /products/1
    # PUT /products/1.json
    def update
      @product = Product.find(params[:id])
      Rails.logger.info(">>>product Controller>>UPDATE: #{@product.inspect}")
      respond_with do |format|
        if @product.update_attributes(params[:product])
          format.html { redirect_to admin_product_path(@product), notice: 'product was successfully updated.' }
          format.json { head :ok }
        else
          format.html { render action: "edit" }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /products/1
    # DELETE /products/1.json
    def destroy
      @product = Product.find(params[:id])
      @product.destroy

      respond_with do |format|
        format.html { redirect_to admin_products_url }
        format.json { head :ok }
      end
    end


end
