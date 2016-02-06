class AgainstOthersCategory < OthersCategory
  def agreements
    statement_agreements.where(extent: 0)
  end
end
