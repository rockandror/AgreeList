class AddHashedIdToIndividuals < ActiveRecord::Migration
  def change
    add_column :individuals, :hashed_id, :string
  end
end
