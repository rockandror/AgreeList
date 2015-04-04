class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :text
      t.integer :individual_id
      t.integer :statement_id

      t.timestamps
    end
  end
end
