class StatementsController < ApplicationController
  before_action :login_required, only: [:create, :create_and_agree]
  before_action :admin_required, only: [:edit, :update, :destroy, :index]
  before_action :find_statement, only: [:show, :destroy, :update, :edit]
  before_action :redirect_to_statement_url, only: :show

  def quick_create
    @statement = Statement.new(content: params[:question])
    @statement.tag_list = "Others"
    if @statement.save
      if current_user
        unless current_user.email.present?
          current_user.email = params[:email]
          current_user.save
        end
      else
        Individual.find_or_create(email: params[:email])
      end
      LogMailer.log_email("@#{params[:email]} has created '#{@statement.content}'").deliver
      redirect_to @statement
    else
      flash[:error] = @statement.errors.messages[:content].first
      render template: "static_pages/home"
    end
  end

  def new_and_agree
    @statement = Statement.new
  end

  def create_and_agree # from /statement & from user profiles
    @statement = Statement.new(content: params[:content])

    LogMailer.log_email("@#{current_user.twitter} has created '#{@statement.content}'").deliver
    if @statement.save
      Agreement.create(
        statement: @statement,
        individual_id: params[:individual_id] || current_user.id,
        url: params[:url],
        extent: 100)
      redirect_to current_user.email.present? ? (params[:back_url] || @statement) : "/join?back=#{@statement.hashed_id}"
    else
      render action: "new_and_agree"
    end
  end

  # GET /statements
  # GET /statements.json
  def index
    @statements = Statement.order("created_at DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @statements }
    end
  end

  # GET /statements/1
  # GET /statements/1.json
  def show
    @agreements_in_favor = @statement.agreements_in_favor
    @agreements_against = @statement.agreements_against
    @related_statements = Statement.where.not(id: @statement.id).tagged_with(@statement.tags.first).limit(6)

    @comment = Comment.new
    @comments = {}
    @statement.comments.each{|comment| @comments[comment.individual.id] = comment}

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @statement }
    end
  end

  # GET /statements/new
  # GET /statements/new.json
  def new
    @statement = Statement.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @statement }
    end
  end

  # GET /statements/1/edit
  def edit
  end

  # POST /statements
  # POST /statements.json
  def create
    @statement = Statement.new(params.require(:statement).permit(:content))

    if @statement.save
      redirect_to @statement, notice: 'Statement was successfully created'
    else
      render action: "new"
    end
  end

  # PUT /statements/1
  # PUT /statements/1.json
  def update
    respond_to do |format|
      if @statement.update_attributes(params.require(:statement).permit(:content))
        format.html { redirect_to edit_statement_path(Statement.where("id > #{@statement.id}").first), notice: 'Statement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @statement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statements/1
  # DELETE /statements/1.json
  def destroy
    @statement.destroy

    respond_to do |format|
      format.html { redirect_to statements_url }
      format.json { head :no_content }
    end
  end

  private

  def find_statement
    @statement = Statement.find_by_hashed_id(params[:id].split("-").last)
  end

  def redirect_to_statement_url
    redirect_to statement_path(@statement) if params[:id] != @statement.to_param
  end
end
