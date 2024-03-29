class CreatePageViews < ActiveRecord::Migration
  def change
    create_table :page_views do |t|
      t.integer :shortlink_id,    null: false
      t.integer :user_id
      t.text :referrer,           null: false
      t.string :ip_address,       null: false
      t.string :user_agent
      t.timestamps
    end

    add_index :page_views, :shortlink_id
  end
end
