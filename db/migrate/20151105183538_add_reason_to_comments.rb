class AddReasonToComments < ActiveRecord::Migration
  def change
    add_column :agreements, :reason, :text
  end
end
