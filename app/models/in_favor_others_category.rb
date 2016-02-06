class InFavorOthersCategory < OthersCategory
  def agreements
    statement_agreements.where(extent: 100)
  end
end
