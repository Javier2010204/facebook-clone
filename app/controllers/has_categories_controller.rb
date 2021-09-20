class HasCategoriesController < ApplicationController

    def destroy
        @has_category = HasCategory.find(params[:id])
        @has_category.destroy

        respond_to do |format|
            format.html { redirect_to product_path(@has_category.product_id), notice: "Categoria eliminada con exito" }
            format.json { head :no_content }
        end
    end
    
end
