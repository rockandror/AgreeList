class AddRankingToIndividuals < ActiveRecord::Migration
  def change
    add_column :individuals, :ranking, :integer, default: 0
  end
end
