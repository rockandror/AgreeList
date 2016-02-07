class ReasonCategoriesController < ApplicationController
  before_action :category_admin_required
  before_action :set_reason_category, only: [:show, :edit, :update, :destroy]

  # GET /reason_categories
  def index
    @reason_categories = ReasonCategory.all
  end

  # GET /reason_categories/new
  def new
    @reason_category = ReasonCategory.new
  end

  # GET /reason_categories/1/edit
  def edit
  end

  # POST /reason_categories
  def create
    @reason_category = ReasonCategory.new(reason_category_params)

    if @reason_category.save
      redirect_to reason_categories_path, notice: 'Comment category was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /reason_categories/1
  def update
    if @reason_category.update(reason_category_params)
      redirect_to reason_categories_path, notice: 'Comment category was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /reason_categories/1
  def destroy
    @reason_category.destroy
    redirect_to reason_categories_url, notice: 'Comment category was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reason_category
      @reason_category = ReasonCategory.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def reason_category_params
      params.require(:reason_category).permit(:name)
    end
end
