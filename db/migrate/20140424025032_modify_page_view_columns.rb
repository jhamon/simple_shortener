class ModifyPageViewColumns < ActiveRecord::Migration
  def change
    remove_column :page_views, :user_id
    remove_column :page_views, :referrer
    add_column :page_views, :referrer, :text
    change_column :page_views, :user_agent, :text
  end
end
