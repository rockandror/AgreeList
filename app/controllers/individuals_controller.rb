class IndividualsController < ApplicationController
  before_action :login_required, only: [:update, :save_email]
  before_action :load_individual, except: :save_email
  before_action :admin_required, only: :update

  def show
    @agrees = @individual.agrees
    @disagrees = @individual.disagrees
  end

  def edit
  end

  def update
    if @individual.update_attributes(params.require(:individual).permit(:name, :twitter, :email, :bio, :picture))
      redirect_to(params[:back_url].present? ? params[:back_url] : root_path, notice: 'Successfully updated.')
    else
      render action: "edit"
    end
  end

  def save_email
    if current_user.update_attributes(params.require(:individual).permit(:email))
      redirect_to params[:back].try(:keys).try(:first).try(:present?) ? Statement.find_by_hashed_id(params[:back].keys.first) : "/", notice: 'Email saved.'
    else
      render action: "edit"
    end
  end

  private

  def load_individual
    @individual = Individual.find_by_twitter(params[:id]) || Individual.find_by_hashed_id(params[:id].gsub("user-", ""))
  end
end
