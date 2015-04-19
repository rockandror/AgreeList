class AgreeCounters < Thor
  desc "generate",
       "generate agree and disagree counters"

  def generate
    require './config/environment'
    Statement.all.each do |statement|
      statement.agree_counter = statement.agreements_in_favor.size
      statement.disagree_counter = statement.agreements_against.size
      statement.save
    end
  end
end
