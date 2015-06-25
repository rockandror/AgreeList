class UpdatePictureFieldForIndividuals < ActiveRecord::Migration
  def change
    add_column :individuals, :update_picture, :boolean, default: true
  end
end
