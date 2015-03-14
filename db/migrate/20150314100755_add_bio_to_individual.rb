class AddBioToIndividual < ActiveRecord::Migration
  def change
    add_column :individuals, :bio, :text
  end
end
