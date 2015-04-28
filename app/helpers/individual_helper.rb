module IndividualHelper
  def percentage(a)
    a.supporters.size * 100 / a.agreements.size
  end
end
