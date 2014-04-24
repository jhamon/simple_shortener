class DefaultAnonUser < ActiveRecord::Migration
  def change
    change_column :shortlinks, :owner_id, :integer, :default => 0
  end
end
