class OthersCategory
  include TopAgreement
  attr_reader :statement

  def initialize(args)
    @statement = args[:statement]
  end

  def name
    "Others"
  end

  private

  def statement_agreements
    Agreement.where(statement: statement, reason_category_id: nil)
  end
end
