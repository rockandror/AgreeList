class DefaultReasonCategoryIdToNil < ActiveRecord::Migration
  def change
    change_column :agreements, :reason_category_id, :integer, default: nil
  end
end
