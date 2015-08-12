module ApplicationHelper
  def links_to_tags(individual)
    raw individual.tags.map(&:name).map{ |t| link_to(t, tag_path(t))}.join(", ")
  end

  def tag_path(t)
    "/tags/#{t}"
  end

  def percentage(statement)
    total = statement.agreements.size
    total == 0 ? 50 : statement.supporters.size * 100 / total
  end
end
