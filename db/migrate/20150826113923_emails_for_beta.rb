class EmailsForBeta < ActiveRecord::Migration
  def change
    create_table :beta_emails do |t|
      t.string :email
      t.text :comment

      t.timestamps
    end
  end
end
