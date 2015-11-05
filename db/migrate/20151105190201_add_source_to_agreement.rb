class AddSourceToAgreement < ActiveRecord::Migration
  def change
    add_column :agreements, :source, :string
  end
end
