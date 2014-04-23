class CreateShortlinks < ActiveRecord::Migration
  def change
    create_table :shortlinks do |t|
      t.integer :target_url_id, null: false
      t.integer :owner_id
      t.string :code

      t.timestamps
    end
  end
end
