class Comments < Thor
  desc "move_to_agreements",
       "move comments to Agreement"

  def move_to_agreements
    require './config/environment'
    brexit_comments.each do |comment|
      agreement = Agreement.where(individual_id: comment.individual_id, statement_id: comment.statement_id).first
      if agreement
        agreement.reason = comment.text
        agreement.source = comment.source
        agreement.save
        puts "comment_id: #{comment.id} destroyed"
        comment.destroy
      else
        puts "comment_id: #{comment.id} AGREEMENT NOT FOUND but destroyed -----------------"
        comment.destroy
      end
    end
  end

  private

  def brexit_comments
    Comment.all.select{|c| c.statement.id == 7}
  end
end
