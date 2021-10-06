class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: %i[ show edit update destroy admin]
  before_action :set_categories, only: %i[new edit]  

  # GET /products or /products.json
  def index
    @products = Product.all.paginate(page:params[:page], per_page:6)
  end

  def admin
    @this_has_category = HasCategory.where(product: @product, category: category)
  end

  def delete_image_attachment
    @image = ActiveStorage::Blob.find_signed(params[:id])
    @image.attachments.first.purge
    redirect_back(fallback_location: products_path, notice: 'Imagen eliminada con exito')
  end
  

  # GET /products/1 or /products/1.json
  def show
    if user_signed_in? && @product.user == current_user && !params.has_key?(:client)
      render :admin
    end
  end

  # GET /products/new
  def new
    @product = current_user.products.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = current_user.products.create(product_params)
    @product.save_categories

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        @product.save_categories
        if params[:product][:images].present?
          params[:product][:images].each do |image|
            @product.images.attach(image)
          end
        end

        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :description, :price, :state, :cover, category_elements: [], images: [])
    end

    def set_categories
      @categories = Category.all
    end
    
end
