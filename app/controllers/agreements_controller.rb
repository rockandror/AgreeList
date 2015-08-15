class AgreementsController < ApplicationController
  before_action :admin_required, only: :destroy

  def destroy
    @agreement = Agreement.find_by_hashed_id(params[:id])
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
        extent: params[:commit] == "Disagree" ? 0 : 100)
      Comment.create(statement: statement, individual: voter, text: params[:comment])
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
end
