class Upvotes < ActiveRecord::Migration
  def change
    create_table :upvotes do |t|
      t.integer :individual_id, null: false
      t.integer :agreement_id, null: false
      t.timestamps
    end
  end
end
