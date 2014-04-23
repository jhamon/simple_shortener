class CreateTargetUrls < ActiveRecord::Migration
  def change
    create_table :target_urls do |t|
      t.string :url, null: false
      t.timestamps
    end
  end
end
