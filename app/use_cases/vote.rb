class Vote
  attr_reader :statement_id, :individual_id, :extent

  def initialize(args)
    @statement_id = args[:statement_id]
    @individual_id = args[:individual_id]
    @extent = args[:extent]
  end

  def vote!
    if exists?
      update
    else
      create
    end
  end

  private

  def exists?
    @agreement ||= Agreement.where(statement_id: statement_id, individual_id: individual_id).first
    @agreement.present?
  end

  def update
    @agreement.update(
      statement_id: statement_id,
      individual_id: individual_id,
      extent: extent
    )
  end
  
  def create
    Agreement.create(
      statement_id: statement_id,
      individual_id: individual_id,
      extent: extent
    )
  end
end
