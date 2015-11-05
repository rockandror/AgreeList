class RmSourceFromAgreement < ActiveRecord::Migration
  def up
    remove_column :agreements, :source
  end

  def down
    add_column :agreements, :source, :string
  end
end
