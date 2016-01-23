class AddIndividualIdToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :individual_id, :integer
  end
end
