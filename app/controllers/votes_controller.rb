class VotesController < ApplicationController
  def create
    return false unless current_user
    Agreement.create(
      statement_id: params[:statement_id],
      extent: params[:add] == "agreement" ? 100 : 0,
      individual: current_user
    )
    LogMailer.log_email("#{current_user.try(:name)}, ip: #{request.remote_ip} #{params[:add]} for '#{statement.content}'").deliver
  end

  private

  def statement
    Statement.find(params[:statement_id])
  end
end
