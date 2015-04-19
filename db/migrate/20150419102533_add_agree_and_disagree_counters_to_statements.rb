class AddAgreeAndDisagreeCountersToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :agree_counter, :integer, default: 0
    add_column :statements, :disagree_counter, :integer, default: 0
  end
end
