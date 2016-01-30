class ReasonCategories < ActiveRecord::Migration
  def change
    create_table :reason_categories do |t|
      t.string :name, null: false
      t.timestamps null: false
    end
    add_column :agreements, :reason_category_id, :integer
  end
end
