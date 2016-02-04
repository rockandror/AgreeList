class AgreementsController < ApplicationController
  before_action :admin_required, only: [:destroy, :touch]
  before_action :find_agreement, only: [:upvote, :update, :touch, :destroy]

  def upvote
    if upvote = Upvote.where(agreement: @agreement, individual: current_user).first
      upvote.destroy
    else
      Upvote.create(agreement: @agreement, individual: current_user)
    end
    redirect_to statement_path(@agreement.statement)
  end

  def update
    @agreement.reason = params[:agreement][:reason]
    @agreement.reason_category_id = params[:agreement][:reason_category_id].to_i
    @agreement.save
    respond_to do |format|
      format.html { redirect_to "#{statement_path(@agreement.statement)}?order=date" }
      format.js { render json: @agreement.to_json, status: :ok }
    end
  end

  def touch
    @agreement.touch if @agreement
    redirect_to params[:back_url] || root_path
  end

  def destroy
    statement = @agreement.statement
    @agreement.destroy
    redirect_to statement_path(statement)
  end

  def add_supporter
    if spam?
      render status: 401, text: "Your message has to be approved because it seemed spam. Sorry for the inconvenience."
      LogMailer.log_email("spam? params: #{params.inspect}").deliver unless statement_used_by_spammers?
    else
      twitter = params[:name][0] == "@" ? params[:name].gsub("@", "") : nil
      voter = MagicVoter.new(email: params[:email].try(:strip),
                             name: twitter ? nil : params[:name],
                             twitter: twitter,
                             current_user: current_user,
                             adding_myself: params[:add] == "myself"
                            ).find_or_create!
      voter.bio = params[:biography] if params[:biography].present?
      voter.picture_from_url = params[:picture_from_url] if params[:picture_from_url].present?
      voter.save
      statement = Statement.find(params[:statement_id])
      LogMailer.log_email("@#{current_user.try(:twitter)}, email: #{params[:email]}, ip: #{request.remote_ip} added #{voter.name} (@#{voter.try(:twitter)}) to '#{statement.content}'").deliver
      Agreement.create(
        statement_id: params[:statement_id],
        individual_id: voter.id,
        url: params[:source],
        reason: params[:comment],
        reason_category_id: params[:reason_category_id],
        extent: params[:commit] == "Disagree" ? 0 : 100)
      redirect_to statement_path(statement), notice: "Done"
    end
  end

  private

  def spam? # real people have name and surname separated by a space
    !twitter? && !first_and_surname?
  end

  def twitter?
    params[:name][0] == "@"
  end

  def twitter
    params[:name].gsub("@", "")
  end

  def first_and_surname?
    params[:name] =~ /\ /
  end

  def statement_used_by_spammers?
    params[:statement_id] == "113"
  end

  def find_agreement
    @agreement = Agreement.find(params[:id])
  end
end
