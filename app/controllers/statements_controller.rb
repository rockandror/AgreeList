class StatementsController < ApplicationController
  before_action :login_required, only: [:add_supporter, :create, :create_and_agree]
  before_action :admin_required, only: [:edit, :update, :destroy, :index]
  before_action :find_statement, only: [:show, :destroy, :update, :edit]

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

  def add_supporter
    if params[:new_supporter]
      individual = Individual.find_or_create(params[:new_supporter].gsub("@", ""))
    else
      individual = current_user
    end
    statement = Statement.find(params[:statement_id])
    LogMailer.log_email("@#{current_user.twitter} added #{individual.name} (@#{individual.twitter}) to '#{statement.content}'").deliver
    Agreement.create(
      statement_id: params[:statement_id],
      individual_id: individual.id,
      url: params[:source],
      extent: params[:add] == "disagreement" ? 0 : 100)
    redirect_to statement_path(statement)
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
    @related_statements = Statement.where.not(id: @statement.id).tagged_with("entrepreneurship").limit(6)

    @comment = Comment.new
    @comments = @statement.comments.order(:created_at)

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
        format.html { redirect_to @statement, notice: 'Statement was successfully updated.' }
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
end
