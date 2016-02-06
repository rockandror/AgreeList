module TopAgreement
  def top_agreement
    agreements.where(extent: 100).sort_by{|a| - a.upvotes.size}.first
  end

  def top_disagreement
    agreements.where(extent: 0).sort_by{|a| - a.upvotes.size}.first
  end
end
